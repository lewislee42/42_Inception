FROM debian:bullseye

RUN apt-get update -y && apt-get install nginx -y

COPY ./conf /etc/nginx/nginx.conf
COPY ./tools/* /

RUN chmod +x /script.sh

ENTRYPOINT ["/script.sh"]
