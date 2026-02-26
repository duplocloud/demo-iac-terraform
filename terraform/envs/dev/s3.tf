# Main S3 bucket with deterministic naming
resource "aws_s3_bucket" "backend_data" {
  bucket = "${var.name_prefix}-backend-data-${data.aws_caller_identity.current.account_id}-${data.aws_region.current.name}"

  tags = merge(var.tags, {
    env  = "dev"
    Name = "${var.name_prefix}-backend-data"
  })
}

# Enforce bucket owner ownership for all objects
resource "aws_s3_bucket_ownership_controls" "backend_data" {
  bucket = aws_s3_bucket.backend_data.id

  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

# Configure server-side encryption with customer-managed KMS key
resource "aws_s3_bucket_server_side_encryption_configuration" "backend_data" {
  bucket = aws_s3_bucket.backend_data.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "aws:kms"
      kms_master_key_id = aws_kms_key.backend_data.arn
    }
    bucket_key_enabled = true
  }
}

# Block all public access to the bucket
resource "aws_s3_bucket_public_access_block" "backend_data" {
  bucket = aws_s3_bucket.backend_data.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Lifecycle rule to expire objects after 30 days (dev environment)
resource "aws_s3_bucket_lifecycle_configuration" "backend_data" {
  bucket = aws_s3_bucket.backend_data.id

  rule {
    id     = "expire-dev-data"
    status = "Enabled"

    expiration {
      days = 30
    }
  }
}
