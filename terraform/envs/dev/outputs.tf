output "encrypted_bucket_name" {
  description = "Name of the encrypted S3 bucket"
  value       = aws_s3_bucket.encrypted_bucket.id
}

output "encrypted_bucket_arn" {
  description = "ARN of the encrypted S3 bucket"
  value       = aws_s3_bucket.encrypted_bucket.arn
}

output "kms_key_id" {
  description = "ID of the KMS key used for bucket encryption"
  value       = aws_kms_key.bucket_key.id
}

output "kms_key_arn" {
  description = "ARN of the KMS key used for bucket encryption"
  value       = aws_kms_key.bucket_key.arn
}
