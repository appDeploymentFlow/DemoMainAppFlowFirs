FROM node:18
WORKDIR /app
COPY ./app/backend .
RUN npm install
ENV DB_HOST=db
EXPOSE 8080
CMD ["node", "/app/index.js"]