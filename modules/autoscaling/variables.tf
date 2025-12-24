variable "project_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "cluster_name" {
  type        = string
  description = "ECS cluster name"
}

variable "backend_service_name" {
  type        = string
  description = "Backend ECS service name"
}

variable "frontend_service_name" {
  type        = string
  description = "Frontend ECS service name"
}

variable "backend_min_count" {
  type        = number
  description = "Backend minimum task count"
  default     = 1
}

variable "backend_max_count" {
  type        = number
  description = "Backend maximum task count"
  default     = 4
}

variable "frontend_min_count" {
  type        = number
  description = "Frontend minimum task count"
  default     = 1
}

variable "frontend_max_count" {
  type        = number
  description = "Frontend maximum task count"
  default     = 4
}

variable "cpu_target_value" {
  type        = number
  description = "Target CPU utilization percentage"
  default     = 70
}

variable "scale_in_cooldown" {
  type        = number
  description = "Scale in cooldown in seconds"
  default     = 300
}

variable "scale_out_cooldown" {
  type        = number
  description = "Scale out cooldown in seconds"
  default     = 60
}

variable "tags" {
  type    = map(string)
  default = {}
}
