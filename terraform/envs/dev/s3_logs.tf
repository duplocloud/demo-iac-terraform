# S3 Logs Bucket with KMS Encryption and Security Controls
# Created for dev environment only

# Data sources for deterministic naming
data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

# KMS Customer-Managed Encryption Key
resource "aws_kms_key" "s3_logs" {
  description             = "KMS key for S3 logs bucket encryption"
  deletion_window_in_days = 10
  enable_key_rotation     = true

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "Enable IAM User Permissions"
        Effect = "Allow"
        Principal = {
          AWS = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
        }
        Action   = "kms:*"
        Resource = "*"
      },
      {
        Sid    = "Allow S3 to use the key"
        Effect = "Allow"
        Principal = {
          Service = "s3.amazonaws.com"
        }
        Action = [
          "kms:Decrypt",
          "kms:GenerateDataKey"
        ]
        Resource = "*"
      }
    ]
  })

  tags = merge(var.tags, {
    Name    = "${var.name_prefix}-s3-logs-key"
    purpose = "s3-encryption"
    env     = "dev"
  })
}

# KMS Key Alias
resource "aws_kms_alias" "s3_logs" {
  name          = "alias/s3-logs-${data.aws_caller_identity.current.account_id}-${data.aws_region.current.name}"
  target_key_id = aws_kms_key.s3_logs.key_id
}

# S3 Bucket with Deterministic Naming
resource "aws_s3_bucket" "logs" {
  bucket = "${var.name_prefix}-logs-${data.aws_caller_identity.current.account_id}-${data.aws_region.current.name}"

  tags = merge(var.tags, {
    Name    = "${var.name_prefix}-logs"
    purpose = "logs"
    env     = "dev"
  })
}

# S3 Bucket Ownership Controls
resource "aws_s3_bucket_ownership_controls" "logs" {
  bucket = aws_s3_bucket.logs.id

  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

# S3 Server-Side Encryption Configuration
resource "aws_s3_bucket_server_side_encryption_configuration" "logs" {
  bucket = aws_s3_bucket.logs.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "aws:kms"
      kms_master_key_id = aws_kms_key.s3_logs.arn
    }
    bucket_key_enabled = true
  }
}

# S3 Public Access Block
resource "aws_s3_bucket_public_access_block" "logs" {
  bucket = aws_s3_bucket.logs.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# S3 Lifecycle Configuration
resource "aws_s3_bucket_lifecycle_configuration" "logs" {
  bucket = aws_s3_bucket.logs.id

  rule {
    id     = "expire-logs"
    status = "Enabled"

    expiration {
      days = 30
    }
  }
}
