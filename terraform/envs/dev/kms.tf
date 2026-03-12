resource "aws_kms_key" "s3_bucket" {
  description             = "KMS key for S3 bucket encryption (dev)"
  deletion_window_in_days = 30
  enable_key_rotation     = true

  tags = merge(var.tags, {
    env     = "dev"
    purpose = "s3-encryption"
  })

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
}

resource "aws_kms_alias" "s3_bucket" {
  name          = "alias/s3-dev-bucket"
  target_key_id = aws_kms_key.s3_bucket.key_id
}
