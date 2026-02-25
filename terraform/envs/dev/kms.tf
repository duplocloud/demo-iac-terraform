resource "aws_kms_key" "s3" {
  description             = "KMS key for S3 bucket encryption in dev environment"
  deletion_window_in_days = 10
  enable_key_rotation     = true

  tags = module.common.tags
}

resource "aws_kms_alias" "s3" {
  name          = "alias/${var.name_prefix}-dev-s3-key"
  target_key_id = aws_kms_key.s3.key_id
}
