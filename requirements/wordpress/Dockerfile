FROM debian:bullseye

RUN apt-get update -y && apt-get install curl php-fpm php-mysql -y

COPY ./scripts/script.sh

RUN chmod 0777 /script.sh

CMD ["/script.sh"]
