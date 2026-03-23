#run docker role
#ansible-pull -U https://vikaskumars1997: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@github.com/appDeploymentFlow/DemoMainAppFlowFirs.git -d /tmp/ansible_pull_cache -i localhost, -e "COMPONENT=docker" app/ansible_code/playbook.yml
#ansible-pull -U https://vikaskumars1997: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@github.com/appDeploymentFlow/DemoMainAppFlowFirs.git -d /tmp/ansible_pull_cache -i localhost, -e "COMPONENT=${1}" app/ansible_code/playbook.yml
echo -e "accecc token for git is : ${1}"