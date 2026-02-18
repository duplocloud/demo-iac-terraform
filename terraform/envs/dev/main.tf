data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

# Common module 
module "common" {
  source      = "../../modules/common"
  name_prefix = "${var.name_prefix}-${var.env}"
  tags        = merge(var.tags, { env = var.env })
}

# S3 logs bucket details
resource "aws_s3_bucket" "logs" {
  bucket = module.common.log_bucket_name
  acl    = "private"

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = module.common.kms_key_id
        sse_algorithm     = "aws:kms"
      }
    }
  }
}

output "log_bucket_name" {
  value = aws_s3_bucket.logs.id
}

output "log_kms_key_id" {
  value = module.common.kms_key_id
}

output "log_kms_key_alias" {
  value = module.common.kms_alias
}