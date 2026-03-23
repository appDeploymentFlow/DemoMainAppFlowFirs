#run docker role
#ansible-pull -U https://vikaskumars1997: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@github.com/appDeploymentFlow/DemoMainAppFlowFirs.git -d /tmp/ansible_pull_cache -i localhost, -e "COMPONENT=docker" app/ansible_code/playbook.yml
#ansible-pull -U https://${1}:${2}@github.com/appDeploymentFlow/DemoMainAppFlowFirs.git -d /tmp/ansible_pull_cache -i localhost, -e "COMPONENT=${3}" app/ansible_code/playbook.yml
# echo -e "accecc token for git is : ${1}, and my name is : ${2}"
#${1} is the username of github
#${2} is the github access token
#${3} is the name of role

# REF: for store and access secrets https://docs.github.com/en/actions/how-tos/write-workflows/choose-what-workflows-do/use-secrets
# REF: for store and access variable https://docs.github.com/en/actions/how-tos/write-workflows/choose-what-workflows-do/use-variables

##run on worker01
#get worker01 public ip
worker01=$(aws ec2 describe-instances --filters "Name=tag:Name,Values=worker01" --query "Reservations[].Instances[].PublicIpAddress" --output text)
sshpass -p "${4} ssh -o StrictHostKeyChecking=no ubuntu@$worker01 << 'EOF'
ansible-pull -U https://${1}:${2}@github.com/appDeploymentFlow/DemoMainAppFlowFirs.git -d /tmp/ansible_pull_cache -i localhost, -e "COMPONENT=${3}" app/ansible_code/playbook.yml
EOF