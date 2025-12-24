variable "project_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "retention_days" {
  type        = number
  description = "CloudWatch Logs retention in days"
  default     = 1
}

variable "tags" {
  type    = map(string)
  default = {}
}
