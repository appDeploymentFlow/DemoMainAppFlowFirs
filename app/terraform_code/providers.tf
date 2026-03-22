provider "aws" {
  region = "us-east-1"
}
# terraform {
#   backend "s3" {
#     bucket         = "your-terraform-state-bucket"
#     key            = "path/to/terraform.tfstate"
#     region         = "us-east-1"
#     encrypt        = true
#     dynamodb_table = "terraform-locks"  # Optional for locking
#   }
# }   