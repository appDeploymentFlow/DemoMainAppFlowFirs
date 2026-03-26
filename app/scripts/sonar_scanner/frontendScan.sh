sudo docker run -it --name scanner_frontend \
--network expense-network01 \
sonarsource/sonar-scanner-cli \
-v app/frontend:/usr/src \
-Dsonar.sources=. \
-Dsonar.projectKey=${project_key} \
-Dsonar.host.url=http://${WORKER01_PUBLIC_IP}:9000 \
-Dsonar.token=${PROJECT_TOKEN} \
-Dsonar.verbose=true \
|tee app/scripts/sonar_scanner/frontendScan.log