sudo docker volume create --name sonarqube_data
sudo docker volume create --name sonarqube_logs
sudo docker volume create --name sonarqube_extensions
sudo docker run -itd --name sonarqube \
  --network expense-network01 \
  -p 9000:9000 \
  -v sonarqube_data:/opt/sonarqube/data \
  -v sonarqube_logs:/opt/sonarqube/logs \
  -v sonarqube_extensions:/opt/sonarqube/extensions \
  sonarqube:latest
echo "access it on http://${WORKER01_PUBLIC_IP}:9000 with admin:admin"