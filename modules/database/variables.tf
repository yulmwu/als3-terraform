variable "project_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "subnet_ids" {
  type        = list(string)
  description = "Protected subnet IDs for databases"
}

variable "rds_security_group_id" {
  type = string
}

variable "redis_security_group_id" {
  type = string
}

variable "db_name" {
  type = string
}

variable "db_username" {
  type = string
}

variable "db_password" {
  type      = string
  sensitive = true
}

variable "redis_port" {
  type    = number
  default = 6379
}

variable "tags" {
  type    = map(string)
  default = {}
}
