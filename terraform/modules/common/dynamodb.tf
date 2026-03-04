resource "aws_dynamodb_table" "app_data" {
  name         = "${var.name_prefix}-app-data-${data.aws_caller_identity.current.account_id}-${data.aws_region.current.name}"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "id"

  attribute {
    name = "id"
    type = "S"
  }

  server_side_encryption {
    enabled     = true
    kms_key_arn = aws_kms_key.dynamodb.arn
  }

  point_in_time_recovery {
    enabled = true
  }

  tags = merge(var.tags, {
    Name = "${var.name_prefix}-app-data"
  })
}
