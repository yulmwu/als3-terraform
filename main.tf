terraform {
  required_version = ">= 1.5.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.27"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.6"
    }
  }

  backend "s3" {} # configured via env/*.backend.hcl
}

provider "aws" {
  region = var.aws_region
}

data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

resource "random_id" "suffix" {
  byte_length = 2
}

locals {
  name_prefix = "${var.project_name}-${var.env}"
  tags = merge(var.tags, {
    Project     = var.project_name
    Environment = var.env
    ManagedBy   = "terraform"
  })
}

module "networking" {
  source = "./modules/networking"

  project_name           = var.project_name
  environment            = var.env
  vpc_cidr               = var.vpc_cidr
  public_subnet_cidrs    = var.public_subnet_cidrs
  private_subnet_cidrs   = var.private_subnet_cidrs
  protected_subnet_cidrs = var.protected_subnet_cidrs
  enable_nat_gateway     = var.enable_nat_gateway
  tags                   = local.tags
}

module "security_groups" {
  source = "./modules/security-groups"

  project_name       = var.project_name
  environment        = var.env
  vpc_id             = module.networking.vpc_id
  backend_port       = var.backend_container_port
  frontend_port      = var.frontend_container_port
  redis_port         = var.redis_port
  certificate_arn    = var.certificate_arn
  use_cloudflare_ips = var.use_cloudflare_ips
  tags               = local.tags
}

module "alb_backend" {
  source = "./modules/alb"

  name_prefix          = local.name_prefix
  service_name         = "be"
  vpc_id               = module.networking.vpc_id
  subnets              = module.networking.public_subnet_ids
  security_group_id    = module.security_groups.alb_backend_sg_id
  container_port       = var.backend_container_port
  health_check_path    = "/health"
  health_check_matcher = "200"
  certificate_arn      = var.certificate_arn
  random_suffix        = random_id.suffix.hex
  tags                 = local.tags
}

module "alb_frontend" {
  source = "./modules/alb"

  name_prefix          = local.name_prefix
  service_name         = "fe"
  vpc_id               = module.networking.vpc_id
  subnets              = module.networking.public_subnet_ids
  security_group_id    = module.security_groups.alb_frontend_sg_id
  container_port       = var.frontend_container_port
  health_check_path    = "/"
  health_check_matcher = "200"
  certificate_arn      = var.certificate_arn
  random_suffix        = random_id.suffix.hex
  tags                 = local.tags
}

module "storage" {
  source = "./modules/storage"

  project_name  = var.project_name
  environment   = var.env
  bucket_suffix = random_id.suffix.hex
  tags          = local.tags
}

module "iam" {
  source = "./modules/iam"

  project_name  = var.project_name
  environment   = var.env
  s3_bucket_arn = module.storage.s3_bucket_arn
  tags          = local.tags
}

module "monitoring" {
  source = "./modules/monitoring"

  project_name   = var.project_name
  environment    = var.env
  retention_days = 1
  tags           = local.tags
}

module "database" {
  source = "./modules/database"

  project_name                     = var.project_name
  environment                      = var.env
  vpc_id                           = module.networking.vpc_id
  subnet_ids                       = module.networking.protected_subnet_ids
  rds_security_group_id            = module.security_groups.rds_sg_id
  redis_security_group_id          = module.security_groups.redis_sg_id
  db_name                          = var.db_name
  db_username                      = var.db_username
  db_password                      = var.db_password
  redis_port                       = var.redis_port
  db_multi_az                      = var.db_multi_az
  redis_replicas_per_node_group    = var.redis_replicas_per_node_group
  redis_automatic_failover_enabled = var.redis_automatic_failover_enabled
  redis_multi_az_enabled           = var.redis_multi_az_enabled

  tags = local.tags
}

module "compute" {
  source = "./modules/compute"

  project_name                  = var.project_name
  environment                   = var.env
  vpc_id                        = module.networking.vpc_id
  private_subnet_ids            = module.networking.private_subnet_ids
  ecs_security_group_id         = module.security_groups.ecs_tasks_sg_id
  backend_alb_target_group_arn  = module.alb_backend.target_group_arn
  frontend_alb_target_group_arn = module.alb_frontend.target_group_arn
  backend_image                 = "${module.storage.ecr_backend_url}:${var.backend_image_tag}"
  frontend_image                = "${module.storage.ecr_frontend_url}:${var.frontend_image_tag}"
  backend_port                  = var.backend_container_port
  frontend_port                 = var.frontend_container_port
  backend_desired_count         = var.backend_desired_count
  frontend_desired_count        = var.frontend_desired_count
  execution_role_arn            = module.iam.ecs_execution_role_arn
  task_role_arn                 = module.iam.ecs_task_role_arn
  log_group_backend             = module.monitoring.backend_log_group_name
  log_group_frontend            = module.monitoring.frontend_log_group_name
  aws_region                    = data.aws_region.current.region
  tags                          = local.tags

  backend_env_vars = [
    { name = "DATABASE_HOST", value = module.database.rds_endpoint },
    { name = "DATABASE_PORT", value = tostring(module.database.rds_port) },
    { name = "DATABASE_USERNAME", value = var.db_username },
    { name = "DATABASE_PASSWORD", value = var.db_password },
    { name = "DATABASE_NAME", value = var.db_name },
    { name = "REDIS_HOST", value = module.database.redis_endpoint },
    { name = "REDIS_PORT", value = tostring(module.database.redis_port) },
    { name = "JWT_SECRET", value = var.backend_jwt_secret },
    { name = "AWS_REGION", value = data.aws_region.current.region },
    { name = "AWS_S3_BUCKET_NAME", value = module.storage.s3_bucket_name },
    { name = "FRONTEND_URL", value = var.backend_frontend_url },
    { name = "NODE_ENV", value = "production" },
    { name = "USE_GLOBAL_PREFIX", value = "false" }
  ]

  frontend_env_vars = [
    { name = "NEXT_PUBLIC_API_URL", value = var.frontend_next_public_api_url }
  ]
}

module "autoscaling" {
  source = "./modules/autoscaling"

  project_name          = var.project_name
  environment           = var.env
  cluster_name          = module.compute.cluster_name
  backend_service_name  = module.compute.backend_service_name
  frontend_service_name = module.compute.frontend_service_name
  backend_min_capacity  = var.backend_min_capacity
  backend_max_capacity  = var.backend_max_capacity
  frontend_min_capacity = var.frontend_min_capacity
  frontend_max_capacity = var.frontend_max_capacity
  cpu_target_value      = 70
  scale_in_cooldown     = 300
  scale_out_cooldown    = 60
  tags                  = local.tags
}
