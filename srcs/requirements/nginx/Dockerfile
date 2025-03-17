FROM debian:bullseye

# update our list & install nginx
RUN apt-get update 
RUN apt-get install nginx -y

# copy our config certs over
COPY ./conf /etc/nginx/nginx.conf
COPY ./tools/* /

# run nginx in the forground
ENTRYPOINT ["nginx","-g", "daemon off;"]
