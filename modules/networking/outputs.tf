output "vpc_id" {
  value       = aws_vpc.this.id
  description = "VPC ID"
}

output "vpc_cidr" {
  value       = aws_vpc.this.cidr_block
  description = "VPC CIDR block"
}

output "public_subnet_ids" {
  value       = [for s in aws_subnet.public : s.id]
  description = "List of public subnet IDs"
}

output "private_subnet_ids" {
  value       = [for s in aws_subnet.private : s.id]
  description = "List of private subnet IDs"
}

output "protected_subnet_ids" {
  value       = [for s in aws_subnet.protected : s.id]
  description = "List of protected subnet IDs"
}

output "nat_gateway_id" {
  value       = var.enable_nat_gateway ? aws_nat_gateway.this[0].id : null
  description = "NAT Gateway ID (null if disabled)"
}

output "vpc_endpoint_s3_id" {
  value       = aws_vpc_endpoint.s3.id
  description = "S3 VPC Endpoint ID"
}

output "vpc_endpoint_ecr_api_id" {
  value       = aws_vpc_endpoint.ecr_api.id
  description = "ECR API VPC Endpoint ID"
}

output "vpc_endpoint_ecr_dkr_id" {
  value       = aws_vpc_endpoint.ecr_dkr.id
  description = "ECR Docker VPC Endpoint ID"
}

output "vpc_endpoint_logs_id" {
  value       = aws_vpc_endpoint.logs.id
  description = "CloudWatch Logs VPC Endpoint ID"
}
