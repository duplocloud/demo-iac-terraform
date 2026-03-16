resource "aws_kms_key" "s3_dev" {
  description             = "KMS key for S3 bucket encryption in dev environment"
  deletion_window_in_days = 10
  enable_key_rotation     = true

  tags = merge(var.tags, { env = "dev" })
}

resource "aws_kms_alias" "s3_dev" {
  name          = "alias/s3-dev-${data.aws_caller_identity.current.account_id}"
  target_key_id = aws_kms_key.s3_dev.key_id
}
