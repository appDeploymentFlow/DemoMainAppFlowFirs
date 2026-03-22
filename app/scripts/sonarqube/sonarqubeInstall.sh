docker run -d --name sonarqube \
  -p 9000:9000 \
  -p 9001:9001 \
  -v sonarqube_data:/opt/sonarqube/data \
  -v sonarqube_logs:/opt/sonarqube/logs \
  -v sonarqube_extensions:/opt/sonarqube/extensions \
  sonarqube:latest
echo "access it on http://localhost:9000 with admin:admin"