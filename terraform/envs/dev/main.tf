# Data sources for deterministic naming
data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

module "common" {
  source      = "../../modules/common"
  name_prefix = var.name_prefix
  tags        = merge(var.tags, { env = "dev" })
}
