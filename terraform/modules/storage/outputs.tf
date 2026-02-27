output "table_name" {
  value       = aws_dynamodb_table.app_data.name
  description = "Name of the DynamoDB table"
}

output "table_arn" {
  value       = aws_dynamodb_table.app_data.arn
  description = "ARN of the DynamoDB table"
}

output "table_id" {
  value       = aws_dynamodb_table.app_data.id
  description = "ID of the DynamoDB table"
}
