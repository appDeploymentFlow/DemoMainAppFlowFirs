variable "instance" {
  default = {
    # mysql = {
    #     instance_type = "t3.micro"
    # }
    # backend = {
    #     instance_type = "t3.micro"
    # }
    frontend = {
        instance_type = "t3.micro"
    }
  }
}
variable "ami" {
  default = "ami-0b6c6ebed2801a5cb"
}
variable "region" {
  default = "us-east-1"
}