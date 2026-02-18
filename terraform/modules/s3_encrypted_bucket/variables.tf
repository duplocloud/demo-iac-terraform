variable "bucket_name" {
  type        = string
  description = "Base name for the S3 bucket (will be suffixed with account ID and region)"
}

variable "object_expiration_days" {
  type        = number
  default     = 30
  description = "Number of days after which objects expire"
}

variable "kms_deletion_window" {
  type        = number
  default     = 10
  description = "KMS key deletion window in days"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Tags to apply to all resources"
}
