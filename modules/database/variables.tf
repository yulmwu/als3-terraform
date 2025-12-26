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

variable "db_multi_az" {
  type        = bool
  default     = false
  description = "Enable Multi-AZ for PostgreSQL (creates standby replica in different AZ)."
}

variable "redis_replicas_per_node_group" {
  type        = number
  default     = 0
  description = "Number of replica nodes per shard (0 = no replicas)."
}

variable "redis_automatic_failover_enabled" {
  type        = bool
  default     = false
  description = "Enable automatic failover for Redis (requires at least 1 replica)."
}

variable "redis_multi_az_enabled" {
  type        = bool
  default     = false
  description = "Enable Multi-AZ for Redis (distributes nodes across AZs)."
}

variable "tags" {
  type    = map(string)
  default = {}
}
