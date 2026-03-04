output "efs_id" {
  description = "EFS file system ID"
  value       = module.efs.efs_id
}

output "efs_dns_name" {
  description = "EFS DNS name for mounting"
  value       = module.efs.efs_dns_name
}

output "efs_arn" {
  description = "EFS file system ARN"
  value       = module.efs.efs_arn
}
