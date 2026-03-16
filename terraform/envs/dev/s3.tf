resource "aws_s3_bucket" "dev_data" {
  bucket = "${var.name_prefix}-dev-data-${data.aws_caller_identity.current.account_id}"

  tags = merge(var.tags, { env = "dev" })
}

resource "aws_s3_bucket_ownership_controls" "dev_data" {
  bucket = aws_s3_bucket.dev_data.id

  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "dev_data" {
  bucket = aws_s3_bucket.dev_data.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "aws:kms"
      kms_master_key_id = aws_kms_key.s3_dev.arn
    }
  }
}

resource "aws_s3_bucket_public_access_block" "dev_data" {
  bucket = aws_s3_bucket.dev_data.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_lifecycle_configuration" "dev_data" {
  bucket = aws_s3_bucket.dev_data.id

  rule {
    id     = "expire-after-30-days"
    status = "Enabled"

    expiration {
      days = 30
    }
  }
}
