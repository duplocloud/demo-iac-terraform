output "storage_bucket_name" {
  description = "Name of the storage S3 bucket"
  value       = aws_s3_bucket.storage.id
}

output "storage_bucket_arn" {
  description = "ARN of the storage S3 bucket"
  value       = aws_s3_bucket.storage.arn
}

output "storage_kms_key_id" {
  description = "ID of the KMS key used for bucket encryption"
  value       = aws_kms_key.storage_key.id
}
