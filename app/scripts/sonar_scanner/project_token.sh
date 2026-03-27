if [ -n "${WORKER01_PUBLIC_IP}" ]
then
    #Wait for SonarQube to be up
    echo "Waiting for SonarQube to start..."
    # while ! curl -s "http://${WORKER01_PUBLIC_IP}:9000" >> /dev/null; do
    #     printf '.'
    #     sleep 5
    # done
    until curl -s \
    "http://${WORKER01_PUBLIC_IP}:9000/api/system/status" \
    | grep -q '"status":"UP"'
    do
    sleep 5
    echo "Still waiting..."
    done
    # sleep 180s
    #Change default password (admin -> YourNewPassword)
    #Default credentials are admin:admin
    echo "URL of sonarqube server: http://${WORKER01_PUBLIC_IP}:9000"
    echo "Changing admin password..."
    curl -u admin:admin -X POST \
        "http://${WORKER01_PUBLIC_IP}:9000/api/users/change_password?login=admin&previousPassword=admin&password=${1}"
    echo "Password updated successfully."

    echo "Authenticate with new password"
    RESULT=$(curl -u admin:${1} "http://${WORKER01_PUBLIC_IP}:9000/api/authentication/validate" |jq -r .valid)
    #output of curl -u admin:admin "http://${WORKER01_PUBLIC_IP}:9000/api/authentication/validate" will be {"valid":true} if authetication pass
    if [ $RESULT ]
    then
        #Generate a Global Analysis Token
        USER_TOKEN=$(curl -u admin:${1} -X POST \
            "http://${WORKER01_PUBLIC_IP}:9000/api/user_tokens/generate?name=automation-token" | jq -r .token)
        #create project using sonarqube API
        echo "User token for project is: ${USER_TOKEN}"
        #adding user token into gitnub env and can accessable with this job (analysis_code) only by any step
        echo "USER_TOKEN=${USER_TOKEN}" >> $GITHUB_ENV

        #backend project
        backend_project_name=expense_backend
        echo "Backend project name is: ${backend_project_name}"
        #adding backend project name into gitnub env so that i can use this inside next steps backend scan and frontend scan, can't access outside this job (analysis_code)
        echo "backend_project_name=${backend_project_name}" >> $GITHUB_ENV
        backend_project_key=expense_backend_01
        echo "Backend project key is: ${backend_project_key}"
        #adding backend project key into gitnub env so that i can use this inside next steps backend scan and frontend scan, can't access outside this job (analysis_code)
        echo "backend_project_key=${backend_project_key}" >> $GITHUB_ENV

        curl -u admin:${1} -X POST \
            "http://${WORKER01_PUBLIC_IP}:9000/api/projects/create?name=${backend_project_name}&project=${backend_project_key}"
        #Generate a token specifically for this project using sonarqube API
        BACKEND_PROJECT_TOKEN=$(curl -u admin:${1} -X POST \
            "http://${WORKER01_PUBLIC_IP}:9000/api/user_tokens/generate?name=${backend_project_key}-token&projectKey=${backend_project_key}" | jq -r .token) \
            | tee backend_token_response.json \
            | jq -r '.token'
        echo "Backend Project token is : ${BACKEND_PROJECT_TOKEN}"
        #adding backend project token into gitnub env so that i can use this inside next steps backend scan and frontend scan, can't access outside this job (analysis_code)
        echo "BACKEND_PROJECT_TOKEN=${BACKEND_PROJECT_TOKEN}" >> $GITHUB_ENV
        sleep 10s

        #frontend project
        frontend_project_name=expense_frontend
        echo "Frontend project name is: ${frontend_project_name}"
        #adding backend project token into gitnub env so that i can use this inside next steps backend scan and frontend scan, can't access outside this job (analysis_code)
        echo "frontend_project_name=${frontend_project_name}" >> $GITHUB_ENV
        frontend_project_key=expense_frontend_01
        echo "Frontend project key is: ${frontend_project_key}"
        #adding backend project token into gitnub env so that i can use this inside next steps backend scan and frontend scan, can't access outside this job (analysis_code)
        echo "frontend_project_key=${frontend_project_key}" >> $GITHUB_ENV

        curl -u admin:${1} -X POST \
            "http://${WORKER01_PUBLIC_IP}:9000/api/projects/create?name=${frontend_project_name}&project=${frontend_project_key}"
        #Generate a token specifically for this project using sonarqube API
        FRONTEND_PROJECT_TOKEN=$(curl -u admin:${1} -X POST \
            "http://${WORKER01_PUBLIC_IP}:9000/api/user_tokens/generate?name=${frontend_project_key}-token&projectKey=${frontend_project_key}" | jq -r .token) \
            | tee frontend_token_response.json \
            | jq -r '.token'
        echo "Frontend Project token is : ${FRONTEND_PROJECT_TOKEN}"
        #adding backend project token into gitnub env so that i can use this inside next steps backend scan and frontend scan, can't access outside this job (analysis_code)
        echo "FRONTEND_PROJECT_TOKEN=${FRONTEND_PROJECT_TOKEN}" >> $GITHUB_ENV
    else
        echo "authentication failed, password didn't change...."
        sleep 5s
        exit 1
    fi

else
    echo "worker01 public ip is not provided.........."
    echo "Error: worker ip not found"
    sleep 120
    exit 1
fi

# #if forgot projec token value, then you can't see that token value using sonarqube api or using sonarqube Ui because The token value is only shown once at creation time. so
# #Regenerate a new token with the same project name
# FRONTEND_PROJECT_TOKEN=$(curl -u admin:${1} -X POST \
#   "http://${WORKER01_PUBLIC_IP}:9000/api/user_tokens/generate?name=project-token&projectKey=${frontend_project_key}" |jq -r .token)
# #This revokes the old token and creates a new one. 

# #CLI Command to List Token Names (Not Values):
# curl -u admin:${1} \
#   "http://${WORKER01_PUBLIC_IP}:9000/api/user_tokens/search" | jq '.userTokens[].name'