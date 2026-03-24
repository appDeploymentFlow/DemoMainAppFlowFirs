#public ip of instance "worker01" is stored in "workerIP "
workerIP=$(aws ec2 describe-instances --filters "Name=tag:Name,Values=worker01" --query "Reservations[].Instances[].PublicIpAddress" --output text)
sshpass -p "${4}" ssh -o StrictHostKeyChecking=no ubuntu@$workerIP << 'EOF'
ansible-pull -U https://${1}:${2}@github.com/appDeploymentFlow/DemoMainAppFlowFirs.git -d /tmp/ansible_pull_cache -i localhost, -e "COMPONENT=${3}" app/ansible_code/playbook.yml
EOF