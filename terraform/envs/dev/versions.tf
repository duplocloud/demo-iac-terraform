terraform {
required_version = ">= 1.5.0"

required_providers {
aws = {
source  = "hashicorp/aws"
version = ">= 5.0"
}
}
}
EOF

cat > terraform/envs/dev/providers.tf <<'EOF'
provider "aws" {
region = var.aws_region
}
EOF

cat > terraform/envs/dev/variables.tf <<'EOF'
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