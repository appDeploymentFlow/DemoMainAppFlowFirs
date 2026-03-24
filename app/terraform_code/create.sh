cd app/terraform_code
terraform fmt --recursive
#use when want to specify state file for s3
# # #terraform init -backend-config=state.tfvars
# terraform init
terraform init
terraform plan -var ssh_pass=${1} -var user_git=${2} -var access_git${3} -var ansible_role=${4}
sleep 5s
terraform apply -auto-approve -var ssh_pass=${1} -var user_git=${2} -var access_git${3} -var ansible_role=${4}

#when want to specify path where all terrafrom moudle present
# # terraform -chdir=app/terraform_code init
# # terraform -chdir=app/terraform_code plan
# #terraform -chdir=app/terraform_code apply -auto-approve
# echo 'task is already done'