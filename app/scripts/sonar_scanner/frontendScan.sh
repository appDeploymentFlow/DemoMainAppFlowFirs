sudo docker run -itd --name scanner_frontend \
--network expense-network01 \
-v app/frontend:/usr/src \
-Dsonar.sources=. \
-Dsonar.projectKey=${project_key} \
-Dsonar.host.url=http://${WORKER01_PUBLIC_IP}:9000 \
-Dsonar.token=${PROJECT_TOKEN} \
sonarsource/sonar-scanner-cli 