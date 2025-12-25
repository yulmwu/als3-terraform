variable "project_name" {
  type        = string
  description = "Project name for resource naming"
}

variable "environment" {
  type        = string
  description = "Environment name"
}

variable "vpc_cidr" {
  type        = string
  description = "CIDR block for VPC"
}

variable "public_subnet_cidrs" {
  type        = list(string)
  description = "CIDR blocks for public subnets"
}

variable "private_subnet_cidrs" {
  type        = list(string)
  description = "CIDR blocks for private subnets"
}

variable "protected_subnet_cidrs" {
  type        = list(string)
  description = "CIDR blocks for protected subnets (databases)"
}

variable "tags" {
  type        = map(string)
  description = "Common tags"
  default     = {}
}

variable "enable_nat_gateway" {
  type        = bool
  description = "Enable NAT Gateway for private subnets to access internet. If false, private subnets can only access AWS services via VPC endpoints."
  default     = true
}
