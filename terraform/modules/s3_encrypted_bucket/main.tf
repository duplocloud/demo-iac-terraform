# Get current AWS account and region for deterministic naming
data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

# KMS key for S3 bucket encryption
resource "aws_kms_key" "bucket" {
  description             = "KMS key for S3 bucket ${var.bucket_name}"
  deletion_window_in_days = var.kms_deletion_window
  enable_key_rotation     = true

  tags = var.tags
}

# KMS alias for easier reference
resource "aws_kms_alias" "bucket" {
  name          = "alias/${var.bucket_name}"
  target_key_id = aws_kms_key.bucket.key_id
}

# S3 bucket with deterministic naming
resource "aws_s3_bucket" "main" {
  bucket = "${var.bucket_name}-${data.aws_caller_identity.current.account_id}-${data.aws_region.current.name}"

  tags = merge(
    var.tags,
    {
      Name = var.bucket_name
    }
  )
}

# Bucket ownership controls - BucketOwnerEnforced
resource "aws_s3_bucket_ownership_controls" "main" {
  bucket = aws_s3_bucket.main.id

  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

# Server-side encryption with customer-managed KMS key
resource "aws_s3_bucket_server_side_encryption_configuration" "main" {
  bucket = aws_s3_bucket.main.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "aws:kms"
      kms_master_key_id = aws_kms_key.bucket.arn
    }
    bucket_key_enabled = true
  }
}

# Public access block - all restrictions enabled
resource "aws_s3_bucket_public_access_block" "main" {
  bucket = aws_s3_bucket.main.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Lifecycle configuration - expire objects after 30 days
resource "aws_s3_bucket_lifecycle_configuration" "main" {
  bucket = aws_s3_bucket.main.id

  rule {
    id     = "expire-objects"
    status = "Enabled"

    expiration {
      days = var.object_expiration_days
    }
  }
}
