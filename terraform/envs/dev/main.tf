module "common" {
  source      = "../../modules/common"
  name_prefix = var.name_prefix
  tags        = merge(var.tags, { env = "dev" })
}

module "app_logs_bucket" {
  source      = "../../modules/app_logs_bucket"
  name_prefix = var.name_prefix
  tags        = merge(var.tags, { env = "dev" })
}
