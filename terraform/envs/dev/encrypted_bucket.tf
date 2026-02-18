module "encrypted_bucket" {
  source      = "../../modules/encrypted_bucket"
  name_prefix = var.name_prefix
  tags        = merge(var.tags, { env = "dev" })
}
