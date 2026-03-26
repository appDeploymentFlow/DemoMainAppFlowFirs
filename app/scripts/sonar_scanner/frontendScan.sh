echo "Backend project key is: ${frontend_project_key}"
echo "Backend project token is: ${FRONTEND_PROJECT_TOKEN}"
echo "URL of soanrqube server is: http://${WORKER01_PUBLIC_IP}:9000"
sudo docker run --name scanner_frontend \
--network expense-network01 \
sonarsource/sonar-scanner-cli \
-v app/frontend:/usr/src \
-Dsonar.sources=. \
-Dsonar.projectKey=${frontend_project_key} \
-Dsonar.host.url=http://${WORKER01_PUBLIC_IP}:9000 \
-Dsonar.token=${FRONTEND_PROJECT_TOKEN} \
-Dsonar.verbose=true \
| tee app/scripts/sonar_scanner/frontendScan.log