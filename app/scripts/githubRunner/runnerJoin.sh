worker01IP=$(aws ec2 describe-instances --filters "Name=tag:Name,Values=worker01" --query "Reservations[].Instances[].PublicIpAddress" --output text)
sshpass -p "${2}" ssh -o StrictHostKeyChecking=no ubuntu@$worker01IP << 'EOF'
# TEMPORARY DEBUG: Check if the first 3 characters of the token are correct
echo "Token prefix: ${1:0:3}..."
sudo apt update
##install github cli (gh)
# sudo apt install -y gh
##login into github account using github cli (gh)
# echo "${1}" | gh auth login --with-token --hostname github.com --git-protocol https
##generate runner token using github cli (gh)
# RUNNER_TOKEN=$(gh api --method POST /repos/appDeploymentFlow/DemoMainAppFlowFirs/actions/runners/registration-token -q .token)
##generate runner using curl without login into github
RUNNER_TOKEN=$(curl -L -X POST -H "Accept: application/vnd.github+json" -H "Authorization: Bearer ${1}" -H "X-GitHub-Api-Version: 2026-03-10" https://api.github.com/repos/appDeploymentFlow/DemoMainAppFlowFirs/actions/runners/registration-token |jq -r '.token')
echo "Your runner token is: ${RUNNER_TOKEN}"
if [ -n "$RUNNER_TOKEN" -a "$RUNNER_TOKEN" != "null" ]; then
    echo "Runner token is generated successfully"
    echo "Your runner token is: ${RUNNER_TOKEN}"
else
    echo "Runner token is not genereated, check code...."
    sleep 5s
    exit 1;
fi
RUNNER_NAME="worker01"
REPO_URL="https://github.com/appDeploymentFlow/DemoMainAppFlowFirs"
##install github runner package
mkdir -p actions-runner && cd actions-runner
#-p will ingnore error if directory is already present
curl -o actions-runner-linux-x64-2.332.0.tar.gz -L https://github.com/actions/runner/releases/download/v2.332.0/actions-runner-linux-x64-2.332.0.tar.gz
echo "f2094522a6b9afeab07ffb586d1eb3f190b6457074282796c497ce7dce9e0f2a  actions-runner-linux-x64-2.332.0.tar.gz" | shasum -a 256 -c
tar xzf ./actions-runner-linux-x64-2.332.0.tar.gz
echo "current directory is : $(pwd)"
./config.sh --unattended --replace --url $REPO_URL --token $RUNNER_TOKEN --name $RUNNER_NAME --labels linux,ubuntu,x64,$RUNNER_NAME --work _work
sudo ./svc.sh install
sudo systemctl start  actions.runner.appDeploymentFlow-DemoMainAppFlowFirs.$RUNNER_NAME.service
EOF