variable "name_prefix" {
  type        = string
  description = "Prefix for resource names"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Tags to apply to resources"
}

variable "hash_key" {
  type        = string
  default     = "id"
  description = "Hash key (partition key) for the DynamoDB table"
}

variable "billing_mode" {
  type        = string
  default     = "PAY_PER_REQUEST"
  description = "DynamoDB billing mode (PROVISIONED or PAY_PER_REQUEST)"
}
