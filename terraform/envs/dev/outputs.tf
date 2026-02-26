output "backend_data_bucket_name" {
  description = "Name of the S3 bucket for backend application data"
  value       = aws_s3_bucket.backend_data.id
}

output "backend_data_bucket_arn" {
  description = "ARN of the S3 bucket for IAM policy references"
  value       = aws_s3_bucket.backend_data.arn
}

output "backend_data_kms_key_id" {
  description = "ID of the KMS key used for bucket encryption"
  value       = aws_kms_key.backend_data.id
}
