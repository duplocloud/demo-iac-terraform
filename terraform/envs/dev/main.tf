module "common" {
  source      = "../../modules/common"
  name_prefix = var.name_prefix
  tags        = merge(var.tags, { env = "dev" })
}

# Data sources for deterministic naming
data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

# KMS key for S3 bucket encryption
resource "aws_kms_key" "storage" {
  description             = "KMS key for S3 bucket encryption in dev environment"
  deletion_window_in_days = 10
  enable_key_rotation     = true

  tags = merge(var.tags, {
    env     = "dev"
    purpose = "s3-encryption"
  })
}

resource "aws_kms_alias" "storage" {
  name          = "alias/${var.name_prefix}-dev-storage-key"
  target_key_id = aws_kms_key.storage.key_id
}

# S3 bucket with deterministic naming
resource "aws_s3_bucket" "storage" {
  bucket = "${var.name_prefix}-dev-storage-${data.aws_caller_identity.current.account_id}-${data.aws_region.current.name}"

  tags = merge(var.tags, {
    env     = "dev"
    purpose = "application-data"
  })
}

# Server-side encryption with KMS
resource "aws_s3_bucket_server_side_encryption_configuration" "storage" {
  bucket = aws_s3_bucket.storage.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "aws:kms"
      kms_master_key_id = aws_kms_key.storage.arn
    }
    bucket_key_enabled = true
  }
}

# Block all public access
resource "aws_s3_bucket_public_access_block" "storage" {
  bucket = aws_s3_bucket.storage.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Bucket ownership controls
resource "aws_s3_bucket_ownership_controls" "storage" {
  bucket = aws_s3_bucket.storage.id

  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

# Lifecycle configuration
resource "aws_s3_bucket_lifecycle_configuration" "storage" {
  bucket = aws_s3_bucket.storage.id

  rule {
    id     = "expire-old-objects"
    status = "Enabled"

    expiration {
      days = 30
    }

    noncurrent_version_expiration {
      noncurrent_days = 30
    }
  }
}
