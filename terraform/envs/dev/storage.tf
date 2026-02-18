# KMS key for S3 bucket encryption
resource "aws_kms_key" "bucket_key" {
  description             = "KMS key for S3 bucket encryption in dev environment"
  deletion_window_in_days = 10
  enable_key_rotation     = true

  tags = merge(var.tags, {
    Name = "${var.name_prefix}-dev-bucket-key"
    env  = "dev"
  })
}

resource "aws_kms_alias" "bucket_key_alias" {
  name          = "alias/${var.name_prefix}-dev-bucket-key"
  target_key_id = aws_kms_key.bucket_key.key_id
}

# S3 bucket with deterministic naming
resource "aws_s3_bucket" "encrypted_storage" {
  bucket = "${var.name_prefix}-dev-encrypted-${data.aws_caller_identity.current.account_id}-${data.aws_region.current.name}"

  tags = merge(var.tags, {
    Name = "${var.name_prefix}-dev-encrypted-storage"
    env  = "dev"
  })
}

# S3 bucket ownership controls
resource "aws_s3_bucket_ownership_controls" "encrypted_storage" {
  bucket = aws_s3_bucket.encrypted_storage.id

  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

# S3 bucket server-side encryption configuration
resource "aws_s3_bucket_server_side_encryption_configuration" "encrypted_storage" {
  bucket = aws_s3_bucket.encrypted_storage.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "aws:kms"
      kms_master_key_id = aws_kms_key.bucket_key.arn
    }
    bucket_key_enabled = true
  }
}

# S3 bucket public access block
resource "aws_s3_bucket_public_access_block" "encrypted_storage" {
  bucket = aws_s3_bucket.encrypted_storage.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# S3 bucket lifecycle configuration
resource "aws_s3_bucket_lifecycle_configuration" "encrypted_storage" {
  bucket = aws_s3_bucket.encrypted_storage.id

  rule {
    id     = "expire-objects"
    status = "Enabled"

    expiration {
      days = var.bucket_lifecycle_days
    }
  }
}
