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

variable "db_name" {
  type        = string
  default     = "appdb"
  description = "Application database name"
}

variable "db_username" {
  type        = string
  default     = "dbadmin"
  description = "Database master username"
}

variable "db_password" {
  type        = string
  sensitive   = true
  description = "Database master password (set via environment or tfvars)"
}
