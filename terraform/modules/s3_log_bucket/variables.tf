variable "name_prefix" {
  description = "Name prefix to use for objects created by this module"
  type        = string
}

variable "tags" {
  description = "Tags to apply to all resources created"
  type        = map(string)
  default     = {}
}