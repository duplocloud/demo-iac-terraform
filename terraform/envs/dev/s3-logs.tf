# Data sources for deterministic bucket naming
data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

# KMS key for S3 bucket encryption
resource "aws_kms_key" "app_logs" {
  description             = "KMS key for app logs S3 bucket encryption (dev)"
  deletion_window_in_days = 10
  enable_key_rotation     = true

  tags = merge(var.tags, {
    Name = "${var.name_prefix}-app-logs-kms-dev"
    env  = "dev"
  })
}

resource "aws_kms_alias" "app_logs" {
  name          = "alias/${var.name_prefix}-app-logs-dev"
  target_key_id = aws_kms_key.app_logs.key_id
}

# S3 bucket for application logs
resource "aws_s3_bucket" "app_logs" {
  bucket = "${var.name_prefix}-app-logs-${data.aws_caller_identity.current.account_id}-${data.aws_region.current.name}"

  tags = merge(var.tags, {
    Name    = "${var.name_prefix}-app-logs-dev"
    env     = "dev"
    purpose = "application-logs"
  })
}

# Server-side encryption configuration using KMS
resource "aws_s3_bucket_server_side_encryption_configuration" "app_logs" {
  bucket = aws_s3_bucket.app_logs.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "aws:kms"
      kms_master_key_id = aws_kms_key.app_logs.arn
    }
    bucket_key_enabled = true
  }
}

# Lifecycle policy to expire logs after 30 days
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

# Block all public access
resource "aws_s3_bucket_public_access_block" "app_logs" {
  bucket = aws_s3_bucket.app_logs.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Enforce bucket owner ownership
resource "aws_s3_bucket_ownership_controls" "app_logs" {
  bucket = aws_s3_bucket.app_logs.id

  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}
