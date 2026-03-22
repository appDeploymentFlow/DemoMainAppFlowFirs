provider "aws" {
  region = "us-east-1"
}
terraform {
  backend "s3" {
    bucket         = "expense-bucket-01-705317504531-us-east-1-an"
    key            = "expense/terraform.tfstate"
    region         = "us-east-1"
    #encrypt        = true
    #dynamodb_table = "terraform-locks"  # Optional for locking
  }
}   
# terraform {
#   backend "s3" {}
# }