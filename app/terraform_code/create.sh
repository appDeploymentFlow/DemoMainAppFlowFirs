terraform fmt --recursive
#terraform init -backend-config=state.tfvars
terraform init
terraform plan 
terraform apply --auto-approve