resource "aws_instance" "main" {
  ami = var.ami
  instance_type = var.instance_type
  key_name = "serverKey01"
  subnet_id = aws_subnet.subnet_main.id
  security_groups = [aws_security_group.sg.id]
  availability_zone = var.region
  associate_public_ip_address = true
  root_block_device {
    volume_size = 30
    volume_type = "gp3"
    delete_on_termination = true
  }
  # instance_market_options {
  #   market_type = "spot"
  #   spot_options {
  #     max_price = "0.1"
  #     instance_interruption_behavior = "stop"
  #     spot_instance_type = "persistent"
  #   }
  # }
  tags = {
    Name = var.name
  }
  user_data_base64 = filebase64("./user.sh")
}

resource "null_resource" "install_packages" {
  depends_on = [ aws_instance.main ]
  # Trigger re-running when the instance ID changes
  triggers = {
    instance_id = aws_instance.main.id
  }
  connection { # Enables connection to the remote host
    host     = aws_instance.main.public_ip
    user     = "ubuntu"
    password = var.ssh_pass
    type     = "ssh"
  }
  # Execute a local command
  provisioner "remote-exec" {
    inline = [ 
      "ansible-pull -U https://${var.user_git}:${var.access_git}@github.com/appDeploymentFlow/DemoMainAppFlowFirs.git -d /tmp/ansible_pull_cache -i localhost, -e COMPONENT=${var.ansible_role} app/ansible_code/playbook.yml"
     ]
  }
}
