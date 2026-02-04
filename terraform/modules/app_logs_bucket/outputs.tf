output "bucket_name" {
  value = aws_s3_bucket.app_logs.bucket
}

output "bucket_arn" {
  value = aws_s3_bucket.app_logs.arn
}

output "kms_key_arn" {
  value = aws_kms_key.app_logs.arn
}
