# Database connection outputs
output "db_instance_endpoint" {
  value       = aws_db_instance.main.endpoint
  description = "RDS instance connection endpoint"
}

output "db_instance_address" {
  value       = aws_db_instance.main.address
  description = "RDS instance address (hostname)"
}

output "db_instance_port" {
  value       = aws_db_instance.main.port
  description = "RDS instance port"
}

output "db_name" {
  value       = aws_db_instance.main.db_name
  description = "Database name"
}

output "db_username" {
  value       = aws_db_instance.main.username
  description = "Database master username"
}

output "db_password_secret_arn" {
  value       = aws_secretsmanager_secret.db_password.arn
  description = "ARN of Secrets Manager secret containing database password"
  sensitive   = true
}

output "db_security_group_id" {
  value       = aws_security_group.rds.id
  description = "Security group ID for RDS instance"
}
