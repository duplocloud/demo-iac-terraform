output "dynamodb_table_name" {
  value       = aws_dynamodb_table.app_data.name
  description = "Name of the DynamoDB table"
}

output "dynamodb_table_arn" {
  value       = aws_dynamodb_table.app_data.arn
  description = "ARN of the DynamoDB table"
}

output "kms_key_id" {
  value       = aws_kms_key.dynamodb.key_id
  description = "KMS key ID for DynamoDB encryption"
}

output "kms_key_alias" {
  value       = aws_kms_alias.dynamodb.name
  description = "KMS key alias"
}

output "iam_role_arn" {
  value       = aws_iam_role.dynamodb_app.arn
  description = "ARN of the IAM role for application access"
}

output "iam_role_name" {
  value       = aws_iam_role.dynamodb_app.name
  description = "Name of the IAM role for application access"
}
