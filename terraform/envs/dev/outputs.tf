output "dynamodb_table_name" {
  value       = module.storage.dynamodb_table_name
  description = "Name of the DynamoDB table for backend application"
}

output "dynamodb_table_arn" {
  value       = module.storage.dynamodb_table_arn
  description = "ARN of the DynamoDB table"
}

output "app_iam_role_arn" {
  value       = module.storage.iam_role_arn
  description = "IAM role ARN for backend application to assume"
}

output "app_iam_role_name" {
  value       = module.storage.iam_role_name
  description = "IAM role name for backend application"
}
