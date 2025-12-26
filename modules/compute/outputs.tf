output "cluster_id" {
  value = aws_ecs_cluster.this.id
}

output "cluster_name" {
  value = aws_ecs_cluster.this.name
}

output "backend_service_name" {
  value = aws_ecs_service.backend.name
}

output "frontend_service_name" {
  value = aws_ecs_service.frontend.name
}

output "migration_task_definition_arn" {
  value       = aws_ecs_task_definition.migration.arn
  description = "ARN of the migration task definition"
}

output "migration_task_family" {
  value       = aws_ecs_task_definition.migration.family
  description = "Family name of the migration task definition"
}

output "private_subnet_ids" {
  value       = var.private_subnet_ids
  description = "Private subnet IDs for ECS tasks"
}

output "ecs_security_group_id" {
  value       = var.ecs_security_group_id
  description = "Security group ID for ECS tasks"
}
