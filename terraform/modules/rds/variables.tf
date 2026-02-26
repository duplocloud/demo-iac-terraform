variable "name_prefix" {
  type        = string
  description = "Prefix for resource naming"
}

variable "db_name" {
  type        = string
  description = "Name of the database to create"
}

variable "db_username" {
  type        = string
  description = "Master username for the database"
}

variable "db_password" {
  type        = string
  sensitive   = true
  description = "Master password for the database"
}

variable "instance_class" {
  type        = string
  default     = "db.t3.micro"
  description = "RDS instance class"
}

variable "allocated_storage" {
  type        = number
  default     = 20
  description = "Allocated storage in GB"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Tags to apply to resources"
}
