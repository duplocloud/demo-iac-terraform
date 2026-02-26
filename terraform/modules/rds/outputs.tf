output "db_instance_endpoint" {
  value       = aws_db_instance.main.endpoint
  description = "Database connection endpoint"
}

output "db_instance_arn" {
  value       = aws_db_instance.main.arn
  description = "ARN of the database instance"
}

output "db_name" {
  value       = aws_db_instance.main.db_name
  description = "Name of the created database"
}

output "security_group_id" {
  value       = aws_security_group.rds.id
  description = "Security group ID for RDS instance"
}
