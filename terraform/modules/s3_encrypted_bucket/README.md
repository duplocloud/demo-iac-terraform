# S3 Encrypted Bucket Module

Terraform module for creating an encrypted S3 bucket with lifecycle policies and access restrictions.

## Features

- Customer-managed KMS encryption
- Deterministic naming using AWS account ID and region
- Bucket ownership controls (BucketOwnerEnforced)
- Public access block (all restrictions enabled)
- Lifecycle policy (30-day object expiration)
- KMS key rotation enabled

## Usage

```hcl
module "encrypted_bucket" {
  source = "../../modules/s3_encrypted_bucket"

  bucket_name              = "my-secure-bucket"
  object_expiration_days   = 30
  tags                     = var.tags
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| bucket_name | Base name for the S3 bucket | string | - | yes |
| object_expiration_days | Days after which objects expire | number | 30 | no |
| kms_deletion_window | KMS key deletion window in days | number | 10 | no |
| tags | Tags to apply to all resources | map(string) | {} | no |

## Outputs

| Name | Description |
|------|-------------|
| bucket_id | The name of the bucket |
| bucket_arn | The ARN of the bucket |
| kms_key_id | The ID of the KMS key |
| kms_key_arn | The ARN of the KMS key |
