variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "name_prefix" {
  type    = string
  default = "demo"
}

variable "tags" {
  type = map(string)
  default = {
    owner = "ai-demo"
  }
}

variable "dynamodb_enable_pitr" {
  description = "Enable point-in-time recovery for DynamoDB table"
  type        = bool
  default     = true
}

variable "dynamodb_enable_streams" {
  description = "Enable DynamoDB Streams for change data capture"
  type        = bool
  default     = false
}
