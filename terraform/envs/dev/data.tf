# Get current AWS account ID for deterministic naming
data "aws_caller_identity" "current" {}

# Get current AWS region
data "aws_region" "current" {}

# Get available AZs for subnet placement
data "aws_availability_zones" "available" {
  state = "available"
}
