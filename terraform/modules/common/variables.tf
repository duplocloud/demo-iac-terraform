variable "name_prefix" {
  description = "Name prefix to use for resources"
  type        = string
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}