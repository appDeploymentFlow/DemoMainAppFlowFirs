module "server" {
  for_each = var.instance
  source = "./module"

  instance_type = each.value.instance_type
  name = each.key
  ami = var.ami
  region = var.region
  ssh_pass = var.ssh_pass
  user_git = var.user_git
  access_git = var.access_git
  ansible_role = var.ansible_role
  
}
# https://github.com/terraform-aws-modules/terraform-aws-ec2-instance?tab=readme-ov-file