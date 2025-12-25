variable "name_prefix" {
  type        = string
  description = "Prefix for resource names"
}

variable "service_name" {
  type        = string
  description = "Service name (e.g., 'backend', 'frontend')"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID"
}

variable "subnets" {
  type        = list(string)
  description = "List of subnet IDs for ALB"
}

variable "security_group_id" {
  type        = string
  description = "Security group ID for ALB"
}

variable "container_port" {
  type        = number
  description = "Container port for target group"
}

variable "health_check_path" {
  type        = string
  description = "Health check path"
  default     = "/"
}

variable "health_check_matcher" {
  type        = string
  description = "Health check HTTP status matcher"
  default     = "200"
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to resources"
  default     = {}
}

variable "random_suffix" {
  type        = string
  description = "Random suffix for unique naming"
}

variable "certificate_arn" {
  type        = string
  description = "ACM certificate ARN for HTTPS listener. If provided, HTTPS listener will be created."
  default     = null
}
