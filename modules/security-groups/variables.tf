variable "project_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "backend_port" {
  type = number
}

variable "frontend_port" {
  type = number
}

variable "redis_port" {
  type    = number
  default = 6379
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "certificate_arn" {
  type        = string
  description = "ACM certificate ARN. If provided, HTTPS port 443 will be allowed on both ALBs."
  default     = null
}

variable "use_cloudflare_ips" {
  type        = bool
  description = "If true, restrict ALB ingress to Cloudflare IP ranges. If false, allow from anywhere (0.0.0.0/0)."
  default     = false
}
