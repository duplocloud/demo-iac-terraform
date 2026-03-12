variable "bucket_name" {
  description = "Name of the S3 bucket"
  type        = string
}

variable "tags" {
  description = "Tags to apply to the S3 bucket"
  type        = map(string)
  default     = {}
}

variable "enable_logging" {
  description = "Enable S3 bucket logging"
  type        = bool
  default     = false
}

variable "logging_target_bucket" {
  description = "Target bucket for S3 access logs"
  type        = string
  default     = ""
}

variable "logging_target_prefix" {
  description = "Prefix for S3 access logs"
  type        = string
  default     = "logs/"
}

variable "lifecycle_rules" {
  description = "List of lifecycle rules for the S3 bucket"
  type = list(object({
    id      = string
    enabled = bool
    transitions = optional(list(object({
      days          = number
      storage_class = string
    })), [])
    expiration = optional(object({
      days = number
    }))
    noncurrent_version_transitions = optional(list(object({
      days          = number
      storage_class = string
    })), [])
    noncurrent_version_expiration = optional(object({
      days = number
    }))
  }))
  default = []
}
