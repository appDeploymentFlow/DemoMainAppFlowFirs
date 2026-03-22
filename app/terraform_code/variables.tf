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
  default = "us-east-1"
}