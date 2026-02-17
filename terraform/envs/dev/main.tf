module "common" {
source      = "../../modules/common" 
name_prefix = var.name_prefix
tags        = merge(var.tags, { env = "dev" })
}

module "s3_log_bucket" {
  source      = "../../modules/s3_log_bucket"
  name_prefix = var.name_prefix 
  tags        = var.tags
}