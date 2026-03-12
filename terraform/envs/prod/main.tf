module "common" {
  source      = "../../modules/common"
  name_prefix = var.name_prefix
  tags        = merge(var.tags, { env = "prod" })
}

# Secure S3 bucket with best practices
module "secure_bucket" {
  source      = "../../modules/s3_bucket"
  bucket_name = "${var.name_prefix}-secure-bucket-prod"
  tags        = merge(var.tags, { env = "prod" })

  # Optional: Configure lifecycle rules for cost optimization
  lifecycle_rules = [
    {
      id      = "archive-old-versions"
      enabled = true
      noncurrent_version_transitions = [
        {
          days          = 30
          storage_class = "STANDARD_IA"
        },
        {
          days          = 90
          storage_class = "GLACIER"
        }
      ]
      noncurrent_version_expiration = {
        days = 730 # Keep for 2 years in prod
      }
    }
  ]
}