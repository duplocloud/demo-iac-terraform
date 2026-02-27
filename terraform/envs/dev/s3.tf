# S3 bucket for application data with deterministic naming
resource "aws_s3_bucket" "app_data" {
  bucket = "${var.name_prefix}-app-data-${data.aws_caller_identity.current.account_id}-${data.aws_region.current.name}-dev"

  tags = merge(var.tags, {
    env  = "dev"
    Name = "${var.name_prefix}-app-data-dev"
  })
}

# Enforce bucket owner for all objects
resource "aws_s3_bucket_ownership_controls" "app_data" {
  bucket = aws_s3_bucket.app_data.id

  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

# Configure server-side encryption with KMS
resource "aws_s3_bucket_server_side_encryption_configuration" "app_data" {
  bucket = aws_s3_bucket.app_data.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "aws:kms"
      kms_master_key_id = aws_kms_key.app_data.arn
    }
    bucket_key_enabled = true
  }
}

# Block all public access
resource "aws_s3_bucket_public_access_block" "app_data" {
  bucket = aws_s3_bucket.app_data.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Lifecycle policy to expire objects after 30 days
resource "aws_s3_bucket_lifecycle_configuration" "app_data" {
  bucket = aws_s3_bucket.app_data.id

  rule {
    id     = "expire-old-objects"
    status = "Enabled"

    expiration {
      days = 30
    }
  }
}
