sudo docker run -it --name scanner_backend \
--network expense-network01 \
-v app/backend:/usr/src \
sonarsource/sonar-scanner-cli \
-Dsonar.sources=. \
-Dsonar.projectKey=${project_key} \
-Dsonar.host.url=http://${WORKER01_PUBLIC_IP}:9000 \
-Dsonar.token=${PROJECT_TOKEN} \
-Dsonar.verbose=true \
|tee app/scripts/sonar_scanner/backendScan.log