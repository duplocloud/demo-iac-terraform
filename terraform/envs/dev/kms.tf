resource "aws_kms_key" "storage" {
  description             = "${var.name_prefix}-dev-storage-key"
  deletion_window_in_days = 10
  enable_key_rotation     = true

  tags = merge(var.tags, {
    env     = "dev"
    purpose = "s3-encryption"
  })
}

resource "aws_kms_alias" "storage" {
  name          = "alias/${var.name_prefix}-dev-storage"
  target_key_id = aws_kms_key.storage.key_id
}
