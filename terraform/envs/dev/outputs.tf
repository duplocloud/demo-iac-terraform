output "efs_id" {
  description = "The ID of the EFS file system"
  value       = aws_efs_file_system.main.id
}

output "efs_dns_name" {
  description = "The DNS name for the EFS file system"
  value       = aws_efs_file_system.main.dns_name
}

output "efs_arn" {
  description = "The ARN of the EFS file system"
  value       = aws_efs_file_system.main.arn
}

output "efs_mount_targets" {
  description = "Map of mount target IDs by subnet"
  value = {
    for k, mt in aws_efs_mount_target.main : k => {
      id                   = mt.id
      network_interface_id = mt.network_interface_id
      ip_address           = mt.ip_address
      subnet_id            = mt.subnet_id
    }
  }
}

output "efs_kms_key_id" {
  description = "The KMS key ID used for EFS encryption"
  value       = aws_kms_key.efs.id
}

output "efs_kms_key_arn" {
  description = "The KMS key ARN used for EFS encryption"
  value       = aws_kms_key.efs.arn
}

output "efs_security_group_id" {
  description = "The security group ID for EFS mount targets"
  value       = aws_security_group.efs.id
}
