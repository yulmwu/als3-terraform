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
  value       = aws_nat_gateway.this.id
  description = "NAT Gateway ID"
}
