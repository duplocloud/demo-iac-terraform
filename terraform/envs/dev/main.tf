module "common" {
  source      = "../../modules/common"
  name_prefix = var.name_prefix
  tags        = merge(var.tags, { env = "dev" })
}

# Data sources for deterministic naming
data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

# KMS key for S3 bucket encryption
resource "aws_kms_key" "s3_logs" {
  description             = "KMS key for S3 application logs bucket encryption"
  deletion_window_in_days = 10
  enable_key_rotation     = true

  tags = merge(var.tags, {
    env     = "dev"
    purpose = "s3-encryption"
  })
}

resource "aws_kms_alias" "s3_logs" {
  name          = "alias/${var.name_prefix}-dev-s3-logs"
  target_key_id = aws_kms_key.s3_logs.key_id
}

# S3 bucket for application logs and artifacts
resource "aws_s3_bucket" "app_logs" {
  bucket = "${var.name_prefix}-dev-app-logs-${data.aws_caller_identity.current.account_id}-${data.aws_region.current.name}"

  tags = merge(var.tags, {
    env     = "dev"
    purpose = "app-logs-artifacts"
  })
}

# Bucket ownership controls
resource "aws_s3_bucket_ownership_controls" "app_logs" {
  bucket = aws_s3_bucket.app_logs.id

  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

# Server-side encryption configuration
resource "aws_s3_bucket_server_side_encryption_configuration" "app_logs" {
  bucket = aws_s3_bucket.app_logs.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "aws:kms"
      kms_master_key_id = aws_kms_key.s3_logs.arn
    }
    bucket_key_enabled = true
  }
}

# Block all public access
resource "aws_s3_bucket_public_access_block" "app_logs" {
  bucket = aws_s3_bucket.app_logs.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Lifecycle policy to expire objects after 30 days
resource "aws_s3_bucket_lifecycle_configuration" "app_logs" {
  bucket = aws_s3_bucket.app_logs.id

  rule {
    id     = "expire-logs"
    status = "Enabled"

    expiration {
      days = 30
    }
  }
}

# Outputs
output "app_logs_bucket_name" {
  description = "Name of the application logs S3 bucket"
  value       = aws_s3_bucket.app_logs.id
}

output "app_logs_bucket_arn" {
  description = "ARN of the application logs S3 bucket"
  value       = aws_s3_bucket.app_logs.arn
}
