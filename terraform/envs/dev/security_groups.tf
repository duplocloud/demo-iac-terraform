resource "aws_security_group" "efs" {
  name        = "${var.name_prefix}-efs-dev"
  description = "Security group for EFS mount targets in dev"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    description = "NFS from VPC"
    from_port   = 2049
    to_port     = 2049
    protocol    = "tcp"
    cidr_blocks = [data.aws_vpc.default.cidr_block]
  }

  egress {
    description = "Allow all outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.tags, {
    Name = "${var.name_prefix}-efs-dev"
    env  = "dev"
  })
}
