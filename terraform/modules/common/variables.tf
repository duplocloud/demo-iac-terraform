variable “name_prefix” {
type = string
}

variable “tags” {
type    = map(string)
default = {}
}
EOF

cat > terraform/modules/common/outputs.tf <<‘EOF’
output “name_prefix” {
value = var.name_prefix
}

output “tags” {
value = var.tags
}