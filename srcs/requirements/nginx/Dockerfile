FROM debian:bullseye

RUN apt-get update -y && apt-get install nginx -y

COPY ./conf /etc/nginx/nginx.conf

RUN service nginx start

CMD ["tail", "-f", "/dev/null"]
