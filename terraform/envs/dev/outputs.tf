output "storage_table_name" {
  value       = module.storage.table_name
  description = "Name of the DynamoDB storage table"
}

output "storage_table_arn" {
  value       = module.storage.table_arn
  description = "ARN of the DynamoDB storage table"
}
