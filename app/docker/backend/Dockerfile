FROM ubuntu
RUN << EOF
apt update && apt install nodejs curl unzip npm vim mysql-client-8.0 wget -y
useradd expense
EOF
WORKDIR /app
COPY ./app/backend .
RUN << EOF
npm install
chmod -R 755 /app
chown -R expense:expense /app
EOF
# RUN mysql -h  -u root -proot < /app/schema/backend.sql
#use -h 127.0.0.1 (localhost) so that docker image can talk to running db container and add schema
# RUN mysql -h 127.0.0.1 -u root -proot < /app/schema/backend.sql
# ENV DB_HOST=db
CMD ["node", "/app/index.js"]