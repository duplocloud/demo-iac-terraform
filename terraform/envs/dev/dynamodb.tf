# DynamoDB table for application data storage
resource "aws_dynamodb_table" "app_data" {
  name         = "${var.name_prefix}-app-data-${var.aws_region}"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "id"

  attribute {
    name = "id"
    type = "S"
  }

  # Enable encryption at rest
  server_side_encryption {
    enabled = true
  }

  # Enable point-in-time recovery for data protection
  point_in_time_recovery {
    enabled = var.dynamodb_enable_pitr
  }

  # Enable DynamoDB Streams for change data capture
  stream_enabled   = var.dynamodb_enable_streams
  stream_view_type = var.dynamodb_enable_streams ? "NEW_AND_OLD_IMAGES" : null

  tags = merge(var.tags, {
    env       = "dev"
    component = "storage"
    purpose   = "application-data"
  })
}
