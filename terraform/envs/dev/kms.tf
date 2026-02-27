# Customer-managed KMS key for S3 bucket encryption
resource "aws_kms_key" "app_data" {
  description             = "KMS key for ${var.name_prefix} app data bucket encryption (dev)"
  deletion_window_in_days = 10
  enable_key_rotation     = true

  tags = merge(var.tags, {
    env  = "dev"
    Name = "${var.name_prefix}-app-data-key-dev"
  })
}

# KMS key alias for discoverability
resource "aws_kms_alias" "app_data" {
  name          = "alias/${var.name_prefix}-app-data-dev"
  target_key_id = aws_kms_key.app_data.key_id
}
