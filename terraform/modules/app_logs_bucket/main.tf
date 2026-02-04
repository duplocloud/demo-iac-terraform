data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

locals {
  bucket_name = "${var.name_prefix}-${var.env}-app-logs-${data.aws_caller_identity.current.account_id}-${data.aws_region.current.name}"
}

resource "aws_kms_key" "app_logs" {
  description         = "KMS key for ${var.env} app logs bucket"
  enable_key_rotation = true
  tags                = var.tags
}

resource "aws_kms_alias" "app_logs" {
  name          = "alias/${var.name_prefix}-${var.env}-app-logs"
  target_key_id = aws_kms_key.app_logs.key_id
}

resource "aws_s3_bucket" "app_logs" {
  bucket = local.bucket_name
  tags   = var.tags
}

resource "aws_s3_bucket_ownership_controls" "app_logs" {
  bucket = aws_s3_bucket.app_logs.id

  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

resource "aws_s3_bucket_public_access_block" "app_logs" {
  bucket                  = aws_s3_bucket.app_logs.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_server_side_encryption_configuration" "app_logs" {
  bucket = aws_s3_bucket.app_logs.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "aws:kms"
      kms_master_key_id = aws_kms_key.app_logs.arn
    }
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "app_logs" {
  bucket = aws_s3_bucket.app_logs.id

  rule {
    id     = "expire-30-days"
    status = "Enabled"

    expiration {
      days = 30
    }
  }
}

resource "aws_s3_bucket_versioning" "app_logs" {
  bucket = aws_s3_bucket.app_logs.id

  versioning_configuration {
    status = var.enable_versioning ? "Enabled" : "Suspended"
  }
}
