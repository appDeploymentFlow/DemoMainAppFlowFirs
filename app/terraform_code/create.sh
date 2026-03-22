cd app/terraform_code
terraform fmt --recursive
# #terraform init -backend-config=state.tfvars
terraform init
terraform plan
# sleep 5s
terraform apply --auto-approve