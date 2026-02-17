module "common" {
  source      = "../../modules/common"
  name_prefix = var.name_prefix
  env         = "dev"
  tags        = merge(var.tags, { env = "dev" })
}

output "log_bucket_id" {
  description = "ID of the log bucket"
  value       = module.common.log_bucket_id
}

output "log_bucket_arn" {
  description = "ARN of the log bucket"
  value       = module.common.log_bucket_arn
}