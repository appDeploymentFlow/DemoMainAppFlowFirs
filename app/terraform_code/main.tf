module "server" {
  for_each = var.instance
  source = "./module"

  instance_type = each.value.instance_type
  ami = var.ami
  region = var.region
}