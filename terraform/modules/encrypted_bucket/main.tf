# Data sources for deterministic naming
data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

# KMS key for bucket encryption
resource "aws_kms_key" "bucket" {
  description             = "KMS key for ${var.name_prefix} encrypted S3 bucket"
  deletion_window_in_days = 30
  enable_key_rotation     = true

  tags = var.tags
}

# KMS alias for the key
resource "aws_kms_alias" "bucket" {
  name          = "alias/${var.name_prefix}-bucket-key"
  target_key_id = aws_kms_key.bucket.key_id
}

# S3 bucket with deterministic naming
resource "aws_s3_bucket" "encrypted" {
  bucket = "${var.name_prefix}-encrypted-${data.aws_caller_identity.current.account_id}-${data.aws_region.current.name}"

  tags = var.tags
}

# Bucket ownership controls
resource "aws_s3_bucket_ownership_controls" "encrypted" {
  bucket = aws_s3_bucket.encrypted.id

  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

# Server-side encryption configuration
resource "aws_s3_bucket_server_side_encryption_configuration" "encrypted" {
  bucket = aws_s3_bucket.encrypted.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "aws:kms"
      kms_master_key_id = aws_kms_key.bucket.arn
    }
    bucket_key_enabled = true
  }
}

# Block all public access
resource "aws_s3_bucket_public_access_block" "encrypted" {
  bucket = aws_s3_bucket.encrypted.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Lifecycle configuration - expire objects after 30 days
resource "aws_s3_bucket_lifecycle_configuration" "encrypted" {
  bucket = aws_s3_bucket.encrypted.id

  rule {
    id     = "expire-objects"
    status = "Enabled"

    expiration {
      days = 30
    }
  }
}
