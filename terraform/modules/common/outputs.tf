output "kms_key_id" {
  description = "Customer managed KMS key ID"
  value       = aws_kms_key.bucket_key.key_id
}

output "kms_alias" {
  description = "Alias for the customer managed KMS key"
  value       = aws_kms_alias.bucket_key_alias.name
}

output "log_bucket_name" {
  description = "Name of the S3 bucket for logs"
  value       = aws_s3_bucket.logs_bucket.id
}