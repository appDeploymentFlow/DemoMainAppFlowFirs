variable "instance" {
  default = {
    # mysql = {
    #     instance_type = "t3.micro"
    # }
    # backend = {
    #     instance_type = "t3.micro"
    # }
    # frontend = {
    #     instance_type = "t3.micro"
    # }
    worker01 = {
        instance_type = "t3.micro"
    }
  }
}
variable "ami" {
  default = "ami-0ec10929233384c7f"
}
variable "region" {
  default = "us-east-1a"
}
# variable "ssh_pass" {
#   default = "rootme@123"
# }
variable "ssh_pass" {}
# variable "user_git" {
#   default = "vikaskumars1997"
# }
variable "user_git" {}
# variable "access_git" {
#   default = "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"
# }
variable "access_git" {}
# variable "ansible_role" {
#   default = "kubernetes"
# }
variable "ansible_role" {}