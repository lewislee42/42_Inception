FROM debian:bullseye

# update our list & install nginx
RUN apt-get update 
RUN apt-get install nginx -y

# copy our config certs over
COPY ./conf /etc/nginx/nginx.conf
COPY ./tools/dhparam.pem ./tools/cert.pem ./tools/cert.key /
COPY ./tools/entrypoint.sh /

RUN chmod +x /entrypoint.sh

# run nginx in the forground
ENTRYPOINT ["/entrypoint.sh"]
