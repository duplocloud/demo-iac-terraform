module “common” {
source      = “../../modules/common”
name_prefix = var.name_prefix
tags        = merge(var.tags, { env = “prod” })
}