output "rds_endpoint" {
  value       = aws_db_instance.primary.address
  description = "RDS endpoint"
}

output "rds_port" {
  value = aws_db_instance.primary.port
}

output "redis_endpoint" {
  value       = aws_elasticache_replication_group.this.primary_endpoint_address
  description = "Redis endpoint"
}

output "redis_port" {
  value = aws_elasticache_replication_group.this.port
}
