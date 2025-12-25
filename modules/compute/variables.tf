variable "project_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "private_subnet_ids" {
  type = list(string)
}

variable "ecs_security_group_id" {
  type = string
}

variable "backend_alb_target_group_arn" {
  type = string
}

variable "frontend_alb_target_group_arn" {
  type = string
}

variable "backend_image" {
  type = string
}

variable "frontend_image" {
  type = string
}

variable "backend_port" {
  type = number
}

variable "frontend_port" {
  type = number
}

variable "backend_desired_count" {
  type    = number
  default = 1
}

variable "frontend_desired_count" {
  type    = number
  default = 1
}

variable "backend_cpu" {
  type    = string
  default = "256"
}

variable "backend_memory" {
  type    = string
  default = "512"
}

variable "migration_cpu" {
  type    = string
  default = "256"
}

variable "migration_memory" {
  type    = string
  default = "512"
}

variable "frontend_cpu" {
  type    = string
  default = "256"
}

variable "frontend_memory" {
  type    = string
  default = "512"
}

variable "backend_env_vars" {
  type = list(object({
    name  = string
    value = string
  }))
  default = []
}

variable "frontend_env_vars" {
  type = list(object({
    name  = string
    value = string
  }))
  default = []
}

variable "execution_role_arn" {
  type = string
}

variable "task_role_arn" {
  type = string
}

variable "log_group_backend" {
  type = string
}

variable "log_group_frontend" {
  type = string
}

variable "aws_region" {
  type = string
}

variable "tags" {
  type    = map(string)
  default = {}
}
