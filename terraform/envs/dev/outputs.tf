output "app_logs_bucket_name" {
  description = "Name of the app logs S3 bucket"
  value       = aws_s3_bucket.app_logs.id
}

output "app_logs_bucket_arn" {
  description = "ARN of the app logs S3 bucket"
  value       = aws_s3_bucket.app_logs.arn
}

output "app_logs_kms_key_id" {
  description = "ID of the KMS key used for app logs encryption"
  value       = aws_kms_key.app_logs.id
}

output "app_logs_kms_key_arn" {
  description = "ARN of the KMS key used for app logs encryption"
  value       = aws_kms_key.app_logs.arn
}
