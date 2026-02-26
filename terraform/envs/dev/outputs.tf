output "database_endpoint" {
  value       = module.rds.db_instance_endpoint
  description = "RDS database endpoint for application connection"
  sensitive   = false
}

output "database_name" {
  value       = module.rds.db_name
  description = "Name of the application database"
}
