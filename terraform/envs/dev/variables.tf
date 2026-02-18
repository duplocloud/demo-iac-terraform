variable "aws_region" {
  description = "AWS region for resources"
  type        = string
  default     = "us-east-1"
}

variable "name_prefix" {
  description = "Prefix for resource naming"
  type        = string
  default     = "demo"
}

variable "tags" {
  description = "Common tags to apply to all resources"
  type        = map(string)
  default = {
    owner = "ai-demo"
  }
}

variable "bucket_lifecycle_days" {
  description = "Days after which to expire objects in the bucket"
  type        = number
  default     = 30
}
