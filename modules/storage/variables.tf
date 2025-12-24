variable "project_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "bucket_suffix" {
  type        = string
  description = "Random suffix for bucket uniqueness"
}

variable "tags" {
  type    = map(string)
  default = {}
}
