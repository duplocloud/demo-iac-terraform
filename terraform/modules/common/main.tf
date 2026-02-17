data "aws_caller_identity" "current" {}

resource "aws_s3_bucket" "log_bucket" {
  bucket        = "${var.name_prefix}-${var.env}-logs-${data.aws_caller_identity.current.account_id}"
  force_destroy = true
}

resource "aws_s3_bucket_ownership_controls" "log_bucket_ownership" {
  bucket = aws_s3_bucket.log_bucket.id
  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

resource "aws_kms_key" "log_bucket_key" {
  description             = "Log bucket encryption key"
  deletion_window_in_days = 30
}

resource "aws_kms_alias" "log_bucket_key_alias" {
  name          = "alias/${var.name_prefix}-${var.env}-log-bucket-key"
  target_key_id = aws_kms_key.log_bucket_key.key_id
}

resource "aws_s3_bucket_server_side_encryption_configuration" "log_bucket_encryption" {
  bucket = aws_s3_bucket.log_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.log_bucket_key.arn
      sse_algorithm     = "aws:kms"
    }
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "log_bucket_lifecycle" {
  bucket = aws_s3_bucket.log_bucket.id

  rule {
    id     = "log_expiration"
    status = "Enabled"

    expiration {
      days = 30
    }
  }
}

resource "aws_s3_bucket_public_access_block" "log_bucket_access" {
  bucket                  = aws_s3_bucket.log_bucket.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}