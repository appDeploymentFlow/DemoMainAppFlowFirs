if [ -n "${WORKER01_PUBLIC_IP}" ]
then
#Wait for SonarQube to be up
echo "Waiting for SonarQube to start..."
until $(curl --output /dev/null --silent --head --fail http://${WORKER01_PUBLIC_IP}:9000); do
    printf '.'
    sleep 5
done
# sleep 180s
#Change default password (admin -> YourNewPassword)
#Default credentials are admin:admin
curl -u admin:admin -X POST \
    "http://${WORKER01_PUBLIC_IP}:9000/api/users/change_password?login=admin&previousPassword=admin&password=${1}"
#Generate a Global Analysis Token
export USER_TOKEN=$(curl -u admin:${1} -X POST \
    "http://${WORKER01_PUBLIC_IP}:9000/api/user_tokens/generate?name=automation-token" | jq -r .token)
#create project using sonarqube API

export project_name=expense
export project_key=expense01

curl -u admin:${1} -X POST \
    "http://${WORKER01_PUBLIC_IP}:9000/api/projects/create?name=${project_name}&project=${project_key}"
#Generate a token specifically for this project using sonarqube API
export PROJECT_TOKEN=$(curl -u admin:${1} -X POST \
    "http://${WORKER01_PUBLIC_IP}:9000/api/user_tokens/generate?name=project-token&projectKey=${project_key}" | jq -r .token)
else
echo "worker01 public ip is not provided.........."
echo "Error: worker ip not found"
sleep 120
exit 1
fi