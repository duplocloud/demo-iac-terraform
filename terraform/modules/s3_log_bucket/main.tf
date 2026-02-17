data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

resource "aws_kms_key" "bucket_key" {
  description             = "Encryption key for S3 log bucket"
  deletion_window_in_days = 30
  enable_key_rotation     = true
}

resource "aws_kms_alias" "key_alias" {
  name          = "alias/s3_log_bucket_${data.aws_region.current.name}_key"
  target_key_id = aws_kms_key.bucket_key.key_id
}

resource "aws_s3_bucket" "log_bucket" {
  bucket = "logs-${data.aws_caller_identity.current.account_id}-${data.aws_region.current.name}"

  force_destroy = true

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = aws_kms_key.bucket_key.arn
        sse_algorithm     = "aws:kms"
      }
    }
  }

  ownership_controls {
    object_ownership = "BucketOwnerPreferred"
    rules {
      object_ownership = "BucketOwnerPreferred"
    }
  }

  public_access_block_configuration {
    block_public_acls       = true
    block_public_policy     = true
    ignore_public_acls      = true
    restrict_public_buckets = true
  }

  lifecycle_rule {
    enabled = true

    transition {
      days          = 30
      storage_class = "GLACIER"
    }

    expiration {
      days = 90
    }
  }
}