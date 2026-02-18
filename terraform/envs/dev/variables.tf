variable "name_prefix" {
  description = "Name prefix to use for resources"
  default     = "demo-iac"
}

variable "env" {
  default = "dev"
}

variable "tags" {
  default = {
    repo = "https://github.com/acme-iac/demo-iac-terraform"
  }
}