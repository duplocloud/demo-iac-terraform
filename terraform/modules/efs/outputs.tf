output "efs_id" {
  description = "EFS file system ID"
  value       = aws_efs_file_system.main.id
}

output "efs_arn" {
  description = "EFS file system ARN"
  value       = aws_efs_file_system.main.arn
}

output "efs_dns_name" {
  description = "DNS name for mounting"
  value       = aws_efs_file_system.main.dns_name
}

output "kms_key_id" {
  description = "KMS key ID used for encryption"
  value       = aws_kms_key.efs.key_id
}

output "kms_key_arn" {
  description = "KMS key ARN"
  value       = aws_kms_key.efs.arn
}

output "security_group_id" {
  description = "Security group ID for EFS access"
  value       = aws_security_group.efs.id
}
