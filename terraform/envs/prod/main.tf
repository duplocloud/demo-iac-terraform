module "common" {
  source      = "../../modules/common"
  name_prefix = "demo-iac-prod"
  tags        = merge(var.tags, { env = "prod" })
}