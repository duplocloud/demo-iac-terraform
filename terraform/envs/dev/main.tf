module "common" {
  source      = "../../modules/common"
  name_prefix = var.name_prefix
  tags        = merge(var.tags, { env = "dev" })
}

module "rds" {
  source = "../../modules/rds"

  name_prefix       = var.name_prefix
  db_name           = var.db_name
  db_username       = var.db_username
  db_password       = var.db_password
  instance_class    = "db.t3.micro"
  allocated_storage = 20
  tags              = module.common.tags
}
