output "ecr_backend_url" {
  value = aws_ecr_repository.backend.repository_url
}

output "ecr_frontend_url" {
  value = aws_ecr_repository.frontend.repository_url
}

output "s3_bucket_name" {
  value = aws_s3_bucket.app.bucket
}

output "s3_bucket_arn" {
  value = aws_s3_bucket.app.arn
}
