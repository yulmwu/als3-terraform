variable "project_name" {
  type        = string
  description = "Project name used for resource naming."
  default     = "als3"
}

variable "env" {
  type        = string
  description = "Environment name."
  default     = "dev"
}

variable "aws_region" {
  type        = string
  description = "AWS region."
  default     = "ap-northeast-2"
}

variable "tags" {
  type        = map(string)
  description = "Additional tags."
  default     = {}
}

variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  type    = list(string)
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidrs" {
  type    = list(string)
  default = ["10.0.11.0/24", "10.0.21.0/24"]
}

variable "protected_subnet_cidrs" {
  type    = list(string)
  default = ["10.0.111.0/24", "10.0.121.0/24"]
}

variable "backend_image_tag" {
  type        = string
  description = "Tag for backend image (ECR repo url is managed by Terraform)."
  default     = "latest"
}

variable "frontend_image_tag" {
  type        = string
  description = "Tag for frontend image."
  default     = "latest"
}

variable "backend_container_port" {
  type    = number
  default = 3000
}

variable "frontend_container_port" {
  type    = number
  default = 4000
}

variable "backend_desired_count" {
  type    = number
  default = 1
}

variable "frontend_desired_count" {
  type    = number
  default = 1
}

variable "backend_min_capacity" {
  type    = number
  default = 1
}

variable "backend_max_capacity" {
  type    = number
  default = 3
}

variable "frontend_min_capacity" {
  type    = number
  default = 1
}

variable "frontend_max_capacity" {
  type    = number
  default = 3
}

variable "backend_jwt_secret" {
  type        = string
  sensitive   = true
  description = "JWT secret for backend authentication. MUST be set via tfvars or environment variable."

  validation {
    condition     = length(var.backend_jwt_secret) >= 32
    error_message = "JWT secret must be at least 32 characters for security."
  }
}

variable "frontend_next_public_api_url" {
  type        = string
  description = "NEXT_PUBLIC_API_URL for frontend (e.g., https://api.rlawnsdud.shop)."
  default     = ""
}

variable "db_name" {
  type    = string
  default = "db"
}

variable "db_username" {
  type        = string
  default     = "postgres"
  description = "Database master username"
}

variable "db_password" {
  type        = string
  sensitive   = true
  description = "Database master password. MUST be set via tfvars or environment variable."

  validation {
    condition     = length(var.db_password) >= 16
    error_message = "Database password must be at least 16 characters for security."
  }
}

variable "redis_port" {
  type    = number
  default = 6379
}
