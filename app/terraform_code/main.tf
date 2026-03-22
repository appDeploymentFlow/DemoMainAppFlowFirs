module "server" {
  for_each = var.instance
  source = "./module"

  instance_type = each.value.instance_type
  name = each.key
  ami = var.ami
  region = var.region
}
# https://github.com/terraform-aws-modules/terraform-aws-ec2-instance?tab=readme-ov-file