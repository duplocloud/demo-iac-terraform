output "name_prefix" {
  value = var.name_prefix
}

output "tags" {
  value = var.tags
}

output "dynamodb_table_name" {
  description = "Name of the DynamoDB table"
  value       = aws_dynamodb_table.app_data.name
}

output "dynamodb_table_arn" {
  description = "ARN of the DynamoDB table"
  value       = aws_dynamodb_table.app_data.arn
}

output "kms_key_id" {
  description = "ID of the KMS key for DynamoDB encryption"
  value       = aws_kms_key.dynamodb.key_id
}

output "kms_key_arn" {
  description = "ARN of the KMS key for DynamoDB encryption"
  value       = aws_kms_key.dynamodb.arn
}
