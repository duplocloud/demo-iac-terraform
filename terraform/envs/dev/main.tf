module "common" {
  source      = "../../modules/common"
  name_prefix = var.name_prefix
  tags        = merge(var.tags, { env = "dev" })
}

module "logs_bucket" {
  source      = "../../modules/logs_bucket"
  name_prefix = var.name_prefix
  tags        = merge(var.tags, { env = "dev" })
}