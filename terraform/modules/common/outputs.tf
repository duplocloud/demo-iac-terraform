output "name_prefix" {
  value = var.name_prefix
}

output "tags" {
  value = var.tags
}

output "storage_bucket_name" {
  description = "Name of the application data S3 bucket"
  value       = aws_s3_bucket.app_data.bucket
}

output "storage_bucket_arn" {
  description = "ARN of the application data S3 bucket"
  value       = aws_s3_bucket.app_data.arn
}

output "storage_kms_key_id" {
  description = "ID of the KMS key used for bucket encryption"
  value       = aws_kms_key.storage.id
}
