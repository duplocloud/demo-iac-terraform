resource "aws_efs_file_system" "main" {
  encrypted        = true
  kms_key_id       = aws_kms_key.efs.arn
  performance_mode = "generalPurpose"
  throughput_mode  = "bursting"

  lifecycle_policy {
    transition_to_ia = "AFTER_30_DAYS"
  }

  tags = merge(
    var.tags,
    {
      Name        = "${var.name_prefix}-efs-${var.environment}-${data.aws_caller_identity.current.account_id}"
      Environment = var.environment
      Purpose     = "Shared file storage for backend application"
    }
  )
}
