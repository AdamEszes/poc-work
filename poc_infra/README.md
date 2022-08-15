#### Deploy to Dev ####
```
terraform init --backend-config=backend_vars/sandbox.tfvars 
terraform plan --var-file=env_vars/sandbox.tfvars 
terraform apply --var-file=env_vars/sandbox.tfvars