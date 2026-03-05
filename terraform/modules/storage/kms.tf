resource "aws_kms_key" "dynamodb" {
  description             = "KMS key for DynamoDB table encryption - ${var.name_prefix}"
  deletion_window_in_days = 10
  enable_key_rotation     = true

  tags = merge(var.tags, {
    Name = "${var.name_prefix}-dynamodb-key"
  })
}

resource "aws_kms_alias" "dynamodb" {
  name          = "alias/${var.name_prefix}-dynamodb-${data.aws_caller_identity.current.account_id}"
  target_key_id = aws_kms_key.dynamodb.key_id
}
