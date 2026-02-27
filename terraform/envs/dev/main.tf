module "common" {
  source      = "../../modules/common"
  name_prefix = var.name_prefix
  tags        = merge(var.tags, { env = "dev" })
}

module "storage" {
  source      = "../../modules/storage"
  name_prefix = var.name_prefix
  tags        = merge(var.tags, { env = "dev" })
}