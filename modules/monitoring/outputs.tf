output "backend_log_group_name" {
  value       = aws_cloudwatch_log_group.backend.name
  description = "Backend CloudWatch log group name"
}

output "frontend_log_group_name" {
  value       = aws_cloudwatch_log_group.frontend.name
  description = "Frontend CloudWatch log group name"
}

output "backend_log_group_arn" {
  value = aws_cloudwatch_log_group.backend.arn
}

output "frontend_log_group_arn" {
  value = aws_cloudwatch_log_group.frontend.arn
}
