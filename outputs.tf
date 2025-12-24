output "backend_alb_dns_name" {
  value       = module.alb_backend.alb_dns_name
  description = "Backend ALB DNS name"
}

output "frontend_alb_dns_name" {
  value       = module.alb_frontend.alb_dns_name
  description = "Frontend ALB DNS name"
}

output "ecr_backend_repository_url" {
  value = module.storage.ecr_backend_url
}

output "ecr_frontend_repository_url" {
  value = module.storage.ecr_frontend_url
}

output "rds_endpoint" {
  value       = module.database.rds_endpoint
  description = "RDS primary endpoint"
}

output "redis_endpoint" {
  value       = module.database.redis_endpoint
  description = "Redis primary endpoint"
}

output "s3_bucket_name" {
  value = module.storage.s3_bucket_name
}

output "vpc_id" {
  value = module.networking.vpc_id
}

output "ecs_cluster_name" {
  value = module.compute.cluster_name
}
