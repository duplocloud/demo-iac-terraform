output "bucket_id" {
  description = "Logs bucket ID"
  value       = module.logs_bucket.bucket_id
}

output "bucket_arn" {
  description = "Logs bucket ARN"
  value       = module.logs_bucket.bucket_arn
}