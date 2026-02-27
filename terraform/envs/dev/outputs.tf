# Bucket name for application configuration
output "app_data_bucket_name" {
  description = "Name of the S3 bucket for application data"
  value       = aws_s3_bucket.app_data.id
}

# Bucket ARN for IAM policies
output "app_data_bucket_arn" {
  description = "ARN of the S3 bucket for application data"
  value       = aws_s3_bucket.app_data.arn
}

# KMS key ARN for encryption reference
output "app_data_kms_key_arn" {
  description = "ARN of the KMS key used for S3 bucket encryption"
  value       = aws_kms_key.app_data.arn
}
