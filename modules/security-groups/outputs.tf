output "alb_backend_sg_id" {
  value = aws_security_group.alb_backend.id
}

output "alb_frontend_sg_id" {
  value = aws_security_group.alb_frontend.id
}

output "ecs_tasks_sg_id" {
  value = aws_security_group.ecs_tasks.id
}

output "rds_sg_id" {
  value = aws_security_group.rds.id
}

output "redis_sg_id" {
  value = aws_security_group.redis.id
}
