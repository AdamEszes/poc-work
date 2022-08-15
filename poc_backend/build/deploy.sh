cd poc_infra
terraform init --backend-config=backend_vars/sandbox.tfvars 
terraform apply --var-file=env_vars/sandbox.tfvars -auto-approve