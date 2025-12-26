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

output "migration_task_family" {
  value       = module.compute.migration_task_family
  description = "Migration task definition family name"
}

output "private_subnet_ids" {
  value       = module.compute.private_subnet_ids
  description = "Private subnet IDs"
}

output "ecs_security_group_id" {
  value       = module.compute.ecs_security_group_id
  description = "ECS tasks security group ID"
}

output "migration_run_command" {
  value       = <<-EOT
    aws ecs run-task \
      --cluster ${module.compute.cluster_name} \
      --task-definition ${module.compute.migration_task_family} \
      --launch-type FARGATE \
      --network-configuration "awsvpcConfiguration={subnets=[${join(",", module.compute.private_subnet_ids)}],securityGroups=[${module.compute.ecs_security_group_id}],assignPublicIp=DISABLED}" \
      --region ${var.aws_region}
  EOT
  description = "Command to manually run the migration task"
}
