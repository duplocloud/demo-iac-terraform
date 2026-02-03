# Demo Terraform Repo (for AI Engineer PR demo)

This repository is intentionally small but realistic.

## Layout
- `terraform/modules/*` reusable modules
- `terraform/envs/dev` and `terraform/envs/prod` environment roots

## Local workflow
From an env folder:

```bash
cd terraform/envs/dev
terraform init -backend=false
terraform fmt -recursive
terraform validate
terraform plan -lock=false -refresh=false
