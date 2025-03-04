FROM debian:bullseye

RUN apt-get update -y && apt-get install mariadb-server -y

RUN sed -i 's/127\.0\.0\.1/0\.0\.0\.0/' /etc/mysql/mariadb.conf.d/50-server.conf

CMD ["./script.sh"]
