variable "name_prefix" {
  type = string
}

variable "env" {
  type = string
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "enable_versioning" {
  type    = bool
  default = false
}
