FROM debian:bullseye

RUN apt-get update -y && apt-get install nginx -y

COPY ./conf /etc/nginx/nginx.conf
COPY ./tools/* /


CMD ["tail", "-f", "/dev/null"]
