module "logs_bucket" {
  source = "terraform-aws-modules/s3-bucket/aws"

  bucket = "${var.name_prefix}-logs-bucket"
  acl    = "private"

  force_destroy = true

  # Bucket policies
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true

  # Bucket encryption
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  # Lifecycle rules
  lifecycle_rule {
    enabled = true
    expiration {
      expired_object_delete_marker = true
    }
  }

  # Tags 
  tags = var.tags
}