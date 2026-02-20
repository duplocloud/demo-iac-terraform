output "storage_bucket_name" {
  description = "Name of the S3 storage bucket"
  value       = aws_s3_bucket.storage.id
}

output "storage_bucket_arn" {
  description = "ARN of the S3 storage bucket"
  value       = aws_s3_bucket.storage.arn
}

output "storage_kms_key_arn" {
  description = "ARN of the KMS key used for bucket encryption"
  value       = aws_kms_key.storage.arn
}
