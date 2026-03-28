FROM nginx:alpine
COPY ./app/frontend /usr/share/nginx/html
COPY ./app/docker/frontend/proxy.conf /etc/nginx/conf.d/default.conf
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]