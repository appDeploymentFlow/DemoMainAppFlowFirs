#while using this make sure in provider.tf use terrafrom {backend "s3" {} }

# bucket = "expense-bucket-001"
# key    = "expense/dev/terraform.tfstate"
# region = "us-east-1"
bucket = "expense-bucket-01-705317504531-us-east-1-an"
key    = "expense/terraform.tfstate"
region = "us-east-1"