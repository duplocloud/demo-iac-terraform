output "name_prefix" {
  value = var.name_prefix
}

output "tags" {
  value = var.tags
}

output "dynamodb_table_name" {
  description = "Name of the DynamoDB table for application data"
  value       = aws_dynamodb_table.app_data.name
}

output "dynamodb_table_arn" {
  description = "ARN of the DynamoDB table for application data"
  value       = aws_dynamodb_table.app_data.arn
}
