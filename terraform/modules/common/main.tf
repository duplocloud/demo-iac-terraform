# Create customer managed KMS key for S3 bucket encryption
resource "aws_kms_key" "bucket_key" {
  description             = "Customer master key to encrypt ${var.name_prefix} S3 bucket"
  enable_key_rotation     = true
  deletion_window_in_days = 30
}

resource "aws_kms_alias" "bucket_key_alias" {
  name          = "alias/${var.name_prefix}-bucket-key"
  target_key_id = aws_kms_key.bucket_key.key_id
}

# Get caller identity to use in unique bucket name 
data "aws_caller_identity" "current" {}

# Create encrypted S3 bucket for logs
resource "aws_s3_bucket" "logs_bucket" {
  bucket        = "${var.name_prefix}-${data.aws_caller_identity.current.account_id}-logs"
  force_destroy = true

  # Encrypt with customer managed KMS key
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = aws_kms_key.bucket_key.arn
        sse_algorithm     = "aws:kms"
      }
    }
  }

  # Enforce bucket ownership controls 
  ownership_controls {
    rule {
      object_ownership = "BucketOwnerEnforced"
    }
  }

  # Block all public access  
  public_access_block_configuration {
    block_public_acls       = true
    block_public_policy     = true
    ignore_public_acls      = true
    restrict_public_buckets = true
  }

  # Expire log files after 30 days
  lifecycle_rule {
    enabled                                = true
    abort_incomplete_multipart_upload_days = 7

    transition {
      days          = 30
      storage_class = "GLACIER"
    }

    expiration {
      days = 90
    }
  }
}