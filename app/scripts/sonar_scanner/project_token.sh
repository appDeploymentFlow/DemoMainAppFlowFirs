if [ -n "${WORKER01_PUBLIC_IP}" ]
then
#Wait for SonarQube to be up
echo "Waiting for SonarQube to start..."
while ! curl -s "http://${WORKER01_PUBLIC_IP}:9000" >> /dev/null; do
    printf '.'
    sleep 5
done
# sleep 180s
#Change default password (admin -> YourNewPassword)
#Default credentials are admin:admin
echo "URL of sonarqube server: http://${WORKER01_PUBLIC_IP}:9000"
echo curl -u admin:admin -X POST \
    "http://${WORKER01_PUBLIC_IP}:9000/api/users/change_password?login=admin&previousPassword=admin&password=${1}"
#Generate a Global Analysis Token
export USER_TOKEN=$(curl -u admin:${1} -X POST \
    "http://${WORKER01_PUBLIC_IP}:9000/api/user_tokens/generate?name=automation-token" | jq -r .token)
#create project using sonarqube API
echo "User token for project is: ${USER_TOKEN}"

#backend project
export backend_project_name=expense_backend
echo "Backend project name is: ${backend_project_name}"
export backend_project_key=expense_backend_01
echo "Backend project key is: ${backend_project_key}"

echo curl -u admin:${1} -X POST \
    "http://${WORKER01_PUBLIC_IP}:9000/api/projects/create?name=${backend_project_name}&project=${backend_project_key}"
#Generate a token specifically for this project using sonarqube API
export BACKEND_PROJECT_TOKEN=$(curl -u admin:${1} -X POST \
    "http://${WORKER01_PUBLIC_IP}:9000/api/user_tokens/generate?name=project-token&projectKey=${backend_project_key}" | jq -r .token)
echo "Backend Project token is : ${BACKEND_PROJECT_TOKEN}"

#frontend project
export frontend_project_name=expense_frontend
echo "Frontend project name is: ${frontend_project_name}"
export frontend_project_key=expense_frontend_01
echo "Frontend project key is: ${frontend_project_key}"

echo curl -u admin:${1} -X POST \
    "http://${WORKER01_PUBLIC_IP}:9000/api/projects/create?name=${frontend_project_name}&project=${frontend_project_key}"
#Generate a token specifically for this project using sonarqube API
export FRONTEND_PROJECT_TOKEN=$(curl -u admin:${1} -X POST \
    "http://${WORKER01_PUBLIC_IP}:9000/api/user_tokens/generate?name=project-token&projectKey=${frontend_project_key}" | jq -r .token)
echo "Frontend Project token is : ${FRONTEND_PROJECT_TOKEN}"
else
echo "worker01 public ip is not provided.........."
echo "Error: worker ip not found"
sleep 120
exit 1
fi