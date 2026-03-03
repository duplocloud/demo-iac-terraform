# KMS key for S3 bucket encryption
resource "aws_kms_key" "app_data_bucket" {
  description             = "KMS key for ${var.name_prefix} application data bucket encryption"
  deletion_window_in_days = 10
  enable_key_rotation     = true

  tags = merge(
    var.tags,
    {
      Name = "${var.name_prefix}-app-data-bucket-key"
      env  = "dev"
    }
  )
}

resource "aws_kms_alias" "app_data_bucket" {
  name          = "alias/${var.name_prefix}-app-data-bucket-key"
  target_key_id = aws_kms_key.app_data_bucket.key_id
}
