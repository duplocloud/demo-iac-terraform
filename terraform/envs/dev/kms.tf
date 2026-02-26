resource "aws_kms_key" "backend_data" {
  description             = "KMS key for ${var.name_prefix} backend data bucket encryption (dev)"
  deletion_window_in_days = 10
  enable_key_rotation     = true

  tags = merge(var.tags, {
    env  = "dev"
    Name = "${var.name_prefix}-backend-data-key"
  })
}

resource "aws_kms_alias" "backend_data" {
  name          = "alias/${var.name_prefix}-backend-data-dev"
  target_key_id = aws_kms_key.backend_data.key_id
}
