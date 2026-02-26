# Get current AWS account ID for deterministic naming
data "aws_caller_identity" "current" {}

# Get current AWS region for deterministic naming
data "aws_region" "current" {}
