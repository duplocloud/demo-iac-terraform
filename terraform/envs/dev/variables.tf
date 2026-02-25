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

# RDS Configuration Variables
variable "db_instance_class" {
  type        = string
  default     = "db.t3.micro"
  description = "RDS instance class"
}

variable "db_allocated_storage" {
  type        = number
  default     = 20
  description = "Allocated storage in GB"
}

variable "db_engine_version" {
  type        = string
  default     = "15.4"
  description = "PostgreSQL engine version"
}

variable "db_name" {
  type        = string
  default     = "appdata"
  description = "Initial database name"
}
