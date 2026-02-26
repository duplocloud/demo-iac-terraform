# Customer-managed KMS key for S3 bucket encryption
resource "aws_kms_key" "app_data" {
  description             = "KMS key for encrypting ${var.name_prefix} application data in dev"
  deletion_window_in_days = 10
  enable_key_rotation     = true

  tags = merge(var.tags, {
    Name = "${var.name_prefix}-app-data-key-dev"
    env  = "dev"
  })
}

# KMS key alias for easier identification
resource "aws_kms_alias" "app_data" {
  name          = "alias/${var.name_prefix}-app-data-dev"
  target_key_id = aws_kms_key.app_data.key_id
}
