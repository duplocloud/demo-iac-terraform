output "dynamodb_table_name" {
  description = "Name of the DynamoDB table for application data"
  value       = aws_dynamodb_table.app_data.name
}

output "dynamodb_table_arn" {
  description = "ARN of the DynamoDB table for IAM policy creation"
  value       = aws_dynamodb_table.app_data.arn
}

output "dynamodb_table_stream_arn" {
  description = "ARN of the DynamoDB stream (if enabled)"
  value       = aws_dynamodb_table.app_data.stream_arn
}

output "dynamodb_table_id" {
  description = "ID of the DynamoDB table"
  value       = aws_dynamodb_table.app_data.id
}
