variable "project_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "s3_bucket_arn" {
  type        = string
  description = "S3 bucket ARN for task role policy"
}

variable "tags" {
  type    = map(string)
  default = {}
}
