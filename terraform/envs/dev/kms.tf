resource "aws_kms_key" "storage_key" {
  description             = "KMS key for ${var.name_prefix}-dev storage bucket encryption"
  deletion_window_in_days = 10
  enable_key_rotation     = true

  tags = merge(var.tags, {
    env  = "dev"
    Name = "${var.name_prefix}-dev-storage-key"
  })
}

resource "aws_kms_alias" "storage_key_alias" {
  name          = "alias/${var.name_prefix}-dev-storage-key"
  target_key_id = aws_kms_key.storage_key.key_id
}
