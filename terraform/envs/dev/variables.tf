variable "aws_region" {
  type        = string
  default     = "us-east-1"
  description = "AWS region for resources"
}

variable "name_prefix" {
  type        = string
  default     = "demo"
  description = "Prefix for resource names"
}

variable "tags" {
  type = map(string)
  default = {
    owner = "ai-demo"
  }
  description = "Common tags for all resources"
}
