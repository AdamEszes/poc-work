### Build in local ###

Use ```.\build\build.sh``` to create artifacts

#### Deploy to Sandbox ####
```
terraform init --backend-config=backend_vars/sandbox.tfvars 
terraform plan --var-file=env_vars/sandbox.tfvars 
terraform apply --var-file=env_vars/sandbox.tfvars
```
#### CI deployment ####

All changes to main branch is deployed to AWS automatically
