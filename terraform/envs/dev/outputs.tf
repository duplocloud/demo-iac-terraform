output "app_data_bucket_name" {
  description = "Name of the application data S3 bucket"
  value       = aws_s3_bucket.app_data.id
}

output "app_data_bucket_arn" {
  description = "ARN of the application data S3 bucket"
  value       = aws_s3_bucket.app_data.arn
}

output "storage_kms_key_arn" {
  description = "ARN of the KMS key used for S3 encryption"
  value       = aws_kms_key.storage.arn
}

output "storage_kms_key_id" {
  description = "ID of the KMS key used for S3 encryption"
  value       = aws_kms_key.storage.key_id
}
