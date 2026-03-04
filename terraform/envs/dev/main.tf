module "common" {
  source      = "../../modules/common"
  name_prefix = var.name_prefix
  tags        = merge(var.tags, { env = "dev" })
}

# Data source to get default VPC for dev environment
data "aws_vpc" "default" {
  default = true
}

module "efs" {
  source = "../../modules/efs"

  name_prefix = module.common.name_prefix
  environment = "dev"
  tags        = module.common.tags

  # VPC configuration - using default VPC for dev environment
  vpc_id              = data.aws_vpc.default.id
  allowed_cidr_blocks = [data.aws_vpc.default.cidr_block]
}
