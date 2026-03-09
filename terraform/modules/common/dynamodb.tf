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
  }

  point_in_time_recovery {
    enabled = false
  }

  deletion_protection_enabled = false

  tags = merge(
    var.tags,
    {
      Name = "${var.name_prefix}-app-data"
    }
  )
}
