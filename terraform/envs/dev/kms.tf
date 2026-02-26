# KMS key for S3 bucket encryption
resource "aws_kms_key" "app_data" {
  description             = "KMS key for ${var.name_prefix}-dev application data bucket encryption"
  deletion_window_in_days = 10
  enable_key_rotation     = true

  tags = merge(var.tags, {
    Name = "${var.name_prefix}-dev-app-data-key"
    env  = "dev"
  })
}

# KMS alias for easier key reference
resource "aws_kms_alias" "app_data" {
  name          = "alias/${var.name_prefix}-dev-app-data"
  target_key_id = aws_kms_key.app_data.key_id
}
