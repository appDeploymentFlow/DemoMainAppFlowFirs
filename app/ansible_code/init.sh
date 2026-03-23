#run docker role
#ansible-pull -U https://vikaskumars1997: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@github.com/appDeploymentFlow/DemoMainAppFlowFirs.git -d /tmp/ansible_pull_cache -i localhost, -e "COMPONENT=docker" app/ansible_code/playbook.yml
#ansible-pull -U https://${1}:${2}@github.com/appDeploymentFlow/DemoMainAppFlowFirs.git -d /tmp/ansible_pull_cache -i localhost, -e "COMPONENT=${3}" app/ansible_code/playbook.yml
echo -e "accecc token for git is : ${1}, and my name is : ${2}"
#${1} is the username of github
#${2} is the github access token
#${3} is the name of role