# DB subnet group spanning multiple AZs
resource "aws_db_subnet_group" "main" {
  name_prefix = "${var.name_prefix}-"
  description = "Subnet group for ${var.db_name} RDS instance"
  subnet_ids = [
    data.aws_subnet.default_az1.id,
    data.aws_subnet.default_az2.id,
  ]

  tags = merge(var.tags, {
    Name = "${var.name_prefix}-db-subnet-group-dev"
    env  = "dev"
  })
}

# RDS PostgreSQL instance
resource "aws_db_instance" "main" {
  # Instance identification
  identifier     = "${var.name_prefix}-postgres-dev-${data.aws_caller_identity.current.account_id}"
  db_name        = var.db_name
  engine         = "postgres"
  engine_version = var.db_engine_version

  # Instance configuration
  instance_class    = var.db_instance_class
  allocated_storage = var.db_allocated_storage
  storage_type      = "gp3"
  storage_encrypted = true

  # Credentials
  username = "dbadmin"
  password = random_password.db_password.result

  # Network configuration
  db_subnet_group_name   = aws_db_subnet_group.main.name
  vpc_security_group_ids = [aws_security_group.rds.id]
  publicly_accessible    = false

  # Backup configuration
  backup_retention_period = 7
  backup_window           = "03:00-04:00"
  maintenance_window      = "mon:04:00-mon:05:00"

  # Dev-specific settings (cost optimization)
  multi_az                   = false
  skip_final_snapshot        = true
  deletion_protection        = false
  apply_immediately          = true
  auto_minor_version_upgrade = true

  # Performance Insights (optional for dev)
  enabled_cloudwatch_logs_exports = ["postgresql", "upgrade"]

  tags = merge(var.tags, {
    Name = "${var.name_prefix}-postgres-dev"
    env  = "dev"
  })
}
