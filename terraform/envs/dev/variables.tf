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
