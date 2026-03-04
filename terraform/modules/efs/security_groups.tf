resource "aws_security_group" "efs" {
  name        = "${var.name_prefix}-efs-${var.environment}-sg"
  description = "Security group for EFS mount targets"
  vpc_id      = var.vpc_id

  ingress {
    description = "NFS access from allowed CIDR blocks"
    from_port   = 2049
    to_port     = 2049
    protocol    = "tcp"
    cidr_blocks = var.allowed_cidr_blocks
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    var.tags,
    {
      Name        = "${var.name_prefix}-efs-${var.environment}-sg"
      Environment = var.environment
      Purpose     = "EFS mount target security"
    }
  )
}
