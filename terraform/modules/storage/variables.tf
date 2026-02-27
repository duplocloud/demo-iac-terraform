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

variable "hash_key_type" {
  type        = string
  default     = "S"
  description = "Hash key attribute type (S for String, N for Number, B for Binary)"
  validation {
    condition     = contains(["S", "N", "B"], var.hash_key_type)
    error_message = "Hash key type must be S (String), N (Number), or B (Binary)"
  }
}

variable "billing_mode" {
  type        = string
  default     = "PAY_PER_REQUEST"
  description = "DynamoDB billing mode (PROVISIONED or PAY_PER_REQUEST)"
}
