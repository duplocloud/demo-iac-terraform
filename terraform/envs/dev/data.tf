# Fetch current AWS account ID for deterministic naming
data "aws_caller_identity" "current" {}

# Fetch current AWS region for deterministic naming
data "aws_region" "current" {}
