# Outputs for backend application integration
output "app_data_bucket_name" {
  description = "Name of the application data S3 bucket"
  value       = aws_s3_bucket.app_data.id
}

output "app_data_bucket_arn" {
  description = "ARN of the application data S3 bucket"
  value       = aws_s3_bucket.app_data.arn
}

output "app_data_bucket_kms_key_id" {
  description = "KMS key ID used for bucket encryption"
  value       = aws_kms_key.app_data_bucket.key_id
}

output "app_data_bucket_kms_key_arn" {
  description = "KMS key ARN used for bucket encryption"
  value       = aws_kms_key.app_data_bucket.arn
}
