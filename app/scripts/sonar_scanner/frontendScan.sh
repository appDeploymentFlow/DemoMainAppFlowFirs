# frontend_project_key=expense_frontend_01
# FRONTEND_PROJECT_TOKEN=squ_cb11ce9336f52e938519607eaf0971b1184b6c92
echo "Frontend project key is: ${frontend_project_key}"
echo "Frontend project token is: ${FRONTEND_PROJECT_TOKEN}"
echo "URL of soanrqube server is: http://${WORKER01_PUBLIC_IP}:9000"
sudo docker run --rm --name scanner_frontend \
--network expense-network01 \
-v ./app:/usr/src \
sonarsource/sonar-scanner-cli \
-Dsonar.projectKey=${frontend_project_key} \
-Dsonar.sources=frontend \
-Dsonar.host.url=http://${WORKER01_PUBLIC_IP}:9000 \
-Dsonar.token=${FRONTEND_PROJECT_TOKEN} \
-Dsonar.verbose=true \
| tee app/scripts/sonar_scanner/frontendScan.log

#other
# sudo docker run --name scanner_frontend \
# --network expense-network01 \
# -v ./app/frontend:/usr/src \
# sonarsource/sonar-scanner-cli \
# -Dsonar.projectKey=${frontend_project_key} \
# -Dsonar.sources=. \
# -Dsonar.host.url=http://${WORKER01_PUBLIC_IP}:9000 \
# -Dsonar.token=${FRONTEND_PROJECT_TOKEN} \
# -Dsonar.verbose=true \
# | tee app/scripts/sonar_scanner/frontendScan.log