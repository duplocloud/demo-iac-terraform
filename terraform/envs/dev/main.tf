module "common" {
  source      = "../../modules/common"
  name_prefix = var.name_prefix
  tags        = merge(var.tags, { env = "dev" })
}

# Data sources for deterministic naming
data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

# KMS key for S3 bucket encryption
resource "aws_kms_key" "app_logs_key" {
  description             = "KMS key for app logs S3 bucket encryption"
  deletion_window_in_days = 10
  enable_key_rotation     = true

  tags = merge(var.tags, {
    Name = "${var.name_prefix}-app-logs-key"
    env  = "dev"
  })
}

resource "aws_kms_alias" "app_logs_key_alias" {
  name          = "alias/${var.name_prefix}-app-logs-key-dev"
  target_key_id = aws_kms_key.app_logs_key.key_id
}

# S3 bucket for app logs
resource "aws_s3_bucket" "app_logs" {
  bucket = "${var.name_prefix}-app-logs-${data.aws_caller_identity.current.account_id}-${data.aws_region.current.name}"

  tags = merge(var.tags, {
    Name = "${var.name_prefix}-app-logs"
    env  = "dev"
  })
}

# S3 bucket encryption using KMS
resource "aws_s3_bucket_server_side_encryption_configuration" "app_logs" {
  bucket = aws_s3_bucket.app_logs.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "aws:kms"
      kms_master_key_id = aws_kms_key.app_logs_key.arn
    }
    bucket_key_enabled = true
  }
}

# S3 bucket lifecycle policy - expire objects after 30 days
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

# Block all public access to the bucket
resource "aws_s3_bucket_public_access_block" "app_logs" {
  bucket = aws_s3_bucket.app_logs.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# S3 bucket ownership controls
resource "aws_s3_bucket_ownership_controls" "app_logs" {
  bucket = aws_s3_bucket.app_logs.id

  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}
