#!/bin/bash
for i in {1..10}; do
  ping -c 1 google.com && break || sleep 5
done
#sudo apt-get update && sudo apt-get install -y gnupg software-properties-common unzip
#sudo curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "/opt/awscliv2.zip"
#sudo unzip /opt/awscliv2.zip -d /opt/
#install aws cli
# sudo /opt/aws/install
# wget -O- https://apt.releases.hashicorp.com/gpg | \
# gpg --dearmor | \
# sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg > /dev/null
# gpg --no-default-keyring \
# --keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg \
# --fingerprint
# echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(grep -oP '(?<=UBUNTU_CODENAME=).*' /etc/os-release || lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
# sudo apt update
# sudo apt-get install terraform ansible git -y
sudo apt update && sudo apt install -y ansible
##change deafult user ubuntu password to login with password
sudo echo 'ubuntu:rootme@123'|sudo chpasswd
##enable password authentication so that instance can accept password
sudo sed -i 's/^#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config
##disable public key authentication so that while login it match password not public key
sudo sed -i 's/^#PubkeyAuthentication yes/PubkeyAuthentication no/' /etc/ssh/sshd_config
##Change to yes to enable challenge-response passwords
sudo sed -i 's/^KbdInteractiveAuthentication no/KbdInteractiveAuthentication yes/' /etc/ssh/sshd_config
sudo systemctl restart ssh

##add virtual memory
sudo fallocate -l 7G /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
echo '/swapfile none swap sw 0 0'| sudo tee -a /etc/fstab
sudo sysctl vm.swappiness=10