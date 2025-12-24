output "backend_scaling_target_id" {
  value       = aws_appautoscaling_target.backend.id
  description = "Backend autoscaling target ID"
}

output "frontend_scaling_target_id" {
  value       = aws_appautoscaling_target.frontend.id
  description = "Frontend autoscaling target ID"
}

output "backend_scaling_policy_arn" {
  value       = aws_appautoscaling_policy.backend_cpu.arn
  description = "Backend scaling policy ARN"
}

output "frontend_scaling_policy_arn" {
  value       = aws_appautoscaling_policy.frontend_cpu.arn
  description = "Frontend scaling policy ARN"
}
