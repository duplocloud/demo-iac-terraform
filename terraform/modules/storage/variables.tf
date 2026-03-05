variable "name_prefix" {
  type        = string
  description = "Prefix for resource naming"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Common tags to apply to all resources"
}

variable "table_name_suffix" {
  type        = string
  default     = "app-data"
  description = "Suffix for DynamoDB table name"
}
