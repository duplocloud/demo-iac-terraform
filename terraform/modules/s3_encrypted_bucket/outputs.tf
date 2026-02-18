output "bucket_id" {
  value       = aws_s3_bucket.main.id
  description = "The name of the bucket"
}

output "bucket_arn" {
  value       = aws_s3_bucket.main.arn
  description = "The ARN of the bucket"
}

output "kms_key_id" {
  value       = aws_kms_key.bucket.id
  description = "The ID of the KMS key"
}

output "kms_key_arn" {
  value       = aws_kms_key.bucket.arn
  description = "The ARN of the KMS key"
}
