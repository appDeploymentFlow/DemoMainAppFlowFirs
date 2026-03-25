worker01IP=$(aws ec2 describe-instances --filters "Name=tag:Name,Values=worker01" --query "Reservations[].Instances[].PublicIpAddress" --output text)
sshpass -p "${2}" ssh -o StrictHostKeyChecking=no ubuntu@$worker01IP << 'EOF'
sudo apt update

##install github cli (gh)
#sudo apt install -y gh
##login into github account using github cli (gh)
#echo "${1}" | gh auth login --with-token --hostname github.com --git-protocol https
##generate runner token using github cli (gh)
#RUNNER_TOKEN=$(gh api --method POST /repos/appDeploymentFlow/DemoMainAppFlowFirs/actions/runners/registration-token -q .token)

RUNNER_TOKEN=$(curl -L -X POST -H "Accept: application/vnd.github+json" -H "Authorization: Bearer ${1}" -H "X-GitHub-Api-Version: 2026-03-10" https://api.github.com/repos/appDeploymentFlow/DemoMainAppFlowFirs/actions/runners/registration-token |jq -r '.token')
echo "runner token is : ${RUNNER_TOKEN}"
RUNNER_NAME="worker01"
echo "runner name will be : ${RUNNER_NAME}"
REPO_URL="https://github.com/appDeploymentFlow/DemoMainAppFlowFirs"
##install github runner package
mkdir actions-runner && cd actions-runner
curl -o actions-runner-linux-x64-2.332.0.tar.gz -L https://github.com/actions/runner/releases/download/v2.332.0/actions-runner-linux-x64-2.332.0.tar.gz
echo "f2094522a6b9afeab07ffb586d1eb3f190b6457074282796c497ce7dce9e0f2a  actions-runner-linux-x64-2.332.0.tar.gz" | shasum -a 256 -c
tar xzf ./actions-runner-linux-x64-2.332.0.tar.gz
echo "current directory is : $(pwd)"
./config.sh --unattended --replace --url $REPO_URL --token $RUNNER_TOKEN --name $RUNNER_NAME --labels linux,ubuntu,x64,$RUNNER_NAME --work _work
sudo ./svc.sh install
sudo systemctl start  actions.runner.appDeploymentFlow-DemoMainAppFlowFirs.$RUNNER_NAME.service
EOF