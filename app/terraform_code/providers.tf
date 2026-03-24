provider "aws" {
  region = "us-east-1"
}
#if use below on then just run "terraform init"
# terraform {
#   backend "s3" {
#     bucket         = "expense-bucket-01-392284424672-us-east-1-an"
#     key            = "expense/terraform.tfstate"
#     region         = "us-east-1"
#     #encrypt        = true
#     #dynamodb_table = "terraform-locks"  # Optional for locking
#   }
# }   

#if below use then methion bucket details in "state.tfvars" (as mentioned here)
#or use command while init only "terraform init -backend-config=state.tfvars"
# terraform {
#   backend "s3" {}
# }
##store state file locally
terraform {
  backend "local" {
    path = "/home/ubuntu/terraform/terraform.tfstate"
  }
}
# Ref: https://developer.hashicorp.com/terraform/language/backend/local