echo "Backend project key is: ${backend_project_key}"
echo "Backend project token is: ${BACKEND_PROJECT_TOKEN}"
echo "URL of soanrqube server is: http://${WORKER01_PUBLIC_IP}:9000"
sudo docker run --rm --name scanner_backend \
--network expense-network01 \
-v ./app:/usr/src \
sonarsource/sonar-scanner-cli \
-Dsonar.projectKey=${backend_project_key} \
-Dsonar.sources=backend \
-Dsonar.host.url=http://${WORKER01_PUBLIC_IP}:9000 \
-Dsonar.token=${BACKEND_PROJECT_TOKEN} \
-Dsonar.verbose=true \
| tee app/scripts/sonar_scanner/backendScan.log

#other 
# sudo docker run --name scanner_backend \
# --network expense-network01 \
# -v ./app/backend:/usr/src \
# sonarsource/sonar-scanner-cli \
# -Dsonar.projectKey=${backend_project_key} \
# -Dsonar.sources=. \
# -Dsonar.host.url=http://${WORKER01_PUBLIC_IP}:9000 \
# -Dsonar.token=${BACKEND_PROJECT_TOKEN} \
# -Dsonar.verbose=true \
# | tee app/scripts/sonar_scanner/backendScan.log