# KMS key for S3 bucket encryption
resource "aws_kms_key" "bucket_key" {
  description             = "KMS key for S3 bucket encryption in dev"
  deletion_window_in_days = 10
  enable_key_rotation     = true

  tags = merge(var.tags, {
    Name = "${var.name_prefix}-s3-key-dev"
    env  = "dev"
  })
}

resource "aws_kms_alias" "bucket_key_alias" {
  name          = "alias/${var.name_prefix}-s3-key-dev"
  target_key_id = aws_kms_key.bucket_key.key_id
}

# S3 bucket with deterministic naming
resource "aws_s3_bucket" "encrypted_bucket" {
  bucket = "${var.name_prefix}-encrypted-${data.aws_caller_identity.current.account_id}-${data.aws_region.current.name}-dev"

  tags = merge(var.tags, {
    Name = "${var.name_prefix}-encrypted-bucket-dev"
    env  = "dev"
  })
}

# Server-side encryption configuration with KMS
resource "aws_s3_bucket_server_side_encryption_configuration" "bucket_encryption" {
  bucket = aws_s3_bucket.encrypted_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.bucket_key.arn
      sse_algorithm     = "aws:kms"
    }
    bucket_key_enabled = true
  }
}

# Ownership controls - BucketOwnerEnforced
resource "aws_s3_bucket_ownership_controls" "bucket_ownership" {
  bucket = aws_s3_bucket.encrypted_bucket.id

  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

# Block all public access
resource "aws_s3_bucket_public_access_block" "bucket_public_access_block" {
  bucket = aws_s3_bucket.encrypted_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Lifecycle policy - expire objects after 30 days
resource "aws_s3_bucket_lifecycle_configuration" "bucket_lifecycle" {
  bucket = aws_s3_bucket.encrypted_bucket.id

  rule {
    id     = "expire-objects-30-days"
    status = "Enabled"

    expiration {
      days = 30
    }
  }
}
