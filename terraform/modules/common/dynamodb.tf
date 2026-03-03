resource "aws_dynamodb_table" "app_data" {
  name         = "${var.name_prefix}-app-data"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "id"

  attribute {
    name = "id"
    type = "S"
  }

  server_side_encryption {
    enabled = true
    # Uses AWS-managed KMS key (aws/dynamodb) by default
  }

  point_in_time_recovery {
    enabled = true
  }

  tags = merge(
    var.tags,
    {
      Name        = "${var.name_prefix}-app-data"
      Description = "Backend application data storage"
    }
  )
}
