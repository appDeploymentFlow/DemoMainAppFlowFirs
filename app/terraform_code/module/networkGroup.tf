resource "aws_vpc" "vpc_main" {
  #region = "us-east-1"
  # region = var.region
  cidr_block = "10.0.0.0/18"
  instance_tenancy = "default"
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name = "myFirstVPC"
  }
}

resource "aws_internet_gateway" "ig" {
  vpc_id = aws_vpc.vpc_main.id
  tags = {
    Name = "myFirstIG"
  }
}

resource "aws_route_table" "route_table" {
  vpc_id = aws_vpc.vpc_main.id
  route {
    cidr_block = aws_vpc.vpc_main.cidr_block
    gateway_id = "local"
  }
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ig.id
  }
  tags = {
    Name = "myFirstRouteTable"
  }
}

resource "aws_security_group" "sg" {
  vpc_id = aws_vpc.vpc_main.id
  description = "Allow ssh and http port"
  ingress {
    description = "allow all ssh port"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  ingress {
    description = "allow http server port"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  egress {
    description = "allow all outbound"
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  tags = {
    Name = "myFirstSG"
  }
}

resource "aws_subnet" "subnet_main" {
  vpc_id = aws_vpc.vpc_main.id
  #availability_zone = "us-east-1a"
  availability_zone = var.region
  cidr_block = "10.0.16.0/20"
  map_public_ip_on_launch = true
  tags = {
    Name = "myFirstSubnet"
  }
}

resource "aws_route_table_association" "name" {
  route_table_id = aws_route_table.route_table.id
  subnet_id = aws_subnet.subnet_main.id
}
