module "common" {
  source      = "../../modules/common"
  name_prefix = var.name_prefix
  tags        = merge(var.tags, { env = "dev" })
}

# Data sources for deterministic naming
data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

# KMS Key for S3 bucket encryption
resource "aws_kms_key" "bucket_key" {
  description             = "KMS key for S3 bucket encryption (dev)"
  deletion_window_in_days = 10
  enable_key_rotation     = true

  tags = merge(var.tags, {
    env  = "dev"
    Name = "${var.name_prefix}-bucket-key-dev"
  })
}

resource "aws_kms_alias" "bucket_key_alias" {
  name          = "alias/${var.name_prefix}-bucket-key-dev"
  target_key_id = aws_kms_key.bucket_key.key_id
}

# S3 Bucket with deterministic naming
resource "aws_s3_bucket" "encrypted_bucket" {
  bucket = "${var.name_prefix}-encrypted-${data.aws_caller_identity.current.account_id}-${data.aws_region.current.name}-dev"

  tags = merge(var.tags, {
    env  = "dev"
    Name = "${var.name_prefix}-encrypted-bucket-dev"
  })
}

# Server-Side Encryption Configuration
resource "aws_s3_bucket_server_side_encryption_configuration" "encrypted_bucket" {
  bucket = aws_s3_bucket.encrypted_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "aws:kms"
      kms_master_key_id = aws_kms_key.bucket_key.arn
    }
    bucket_key_enabled = true
  }
}

# Public Access Block
resource "aws_s3_bucket_public_access_block" "encrypted_bucket" {
  bucket = aws_s3_bucket.encrypted_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Ownership Controls
resource "aws_s3_bucket_ownership_controls" "encrypted_bucket" {
  bucket = aws_s3_bucket.encrypted_bucket.id

  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

# Lifecycle Configuration
resource "aws_s3_bucket_lifecycle_configuration" "encrypted_bucket" {
  bucket = aws_s3_bucket.encrypted_bucket.id

  rule {
    id     = "expire-objects-30-days"
    status = "Enabled"

    expiration {
      days = 30
    }
  }
}
