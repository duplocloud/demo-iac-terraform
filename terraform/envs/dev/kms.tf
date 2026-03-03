# KMS key for S3 bucket encryption
resource "aws_kms_key" "app_data_bucket" {
  description             = "KMS key for ${var.name_prefix}-dev app data bucket encryption"
  deletion_window_in_days = 7
  enable_key_rotation     = true

  tags = merge(var.tags, {
    env     = "dev"
    purpose = "s3-encryption"
  })
}

resource "aws_kms_alias" "app_data_bucket" {
  name          = "alias/${var.name_prefix}-dev-app-data-bucket"
  target_key_id = aws_kms_key.app_data_bucket.key_id
}
