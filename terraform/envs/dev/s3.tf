# Encrypted S3 bucket for development environment
module "demo_bucket" {
  source = "../../modules/s3_encrypted_bucket"

  bucket_name            = "${var.name_prefix}-demo-bucket"
  object_expiration_days = 30

  tags = merge(var.tags, { env = "dev" })
}

# Output bucket information for reference
output "demo_bucket_id" {
  value       = module.demo_bucket.bucket_id
  description = "Development demo bucket name"
}

output "demo_bucket_arn" {
  value       = module.demo_bucket.bucket_arn
  description = "Development demo bucket ARN"
}
