# Output the bucket name for application configuration
output "app_data_bucket_name" {
  description = "Name of the application data S3 bucket"
  value       = aws_s3_bucket.app_data.id
}

# Output the bucket ARN for IAM policy creation
output "app_data_bucket_arn" {
  description = "ARN of the application data S3 bucket"
  value       = aws_s3_bucket.app_data.arn
}

# Output the KMS key ID for reference
output "app_data_kms_key_id" {
  description = "ID of the KMS key used for bucket encryption"
  value       = aws_kms_key.app_data.key_id
}

# Output the KMS key ARN for IAM policy creation
output "app_data_kms_key_arn" {
  description = "ARN of the KMS key used for bucket encryption"
  value       = aws_kms_key.app_data.arn
}
