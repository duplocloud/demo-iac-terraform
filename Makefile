TF_ENVS := terraform/envs/dev terraform/envs/prod

.PHONY: fmt validate init plan

fmt:
@terraform fmt -recursive

validate:
@for d in $(TF_ENVS); do 
echo “==> validate $$d”; 
(cd $$d && terraform init -backend=false >/dev/null && terraform validate); 
done

init:
@for d in $(TF_ENVS); do 
echo “==> init $$d”; 
(cd $$d && terraform init -backend=false); 
done

plan:
@echo “==> plan terraform/envs/dev (best-effort)”; 
(cd terraform/envs/dev && terraform init -backend=false >/dev/null && terraform plan -lock=false -refresh=false)