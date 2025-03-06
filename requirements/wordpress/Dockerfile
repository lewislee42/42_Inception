FROM debian:bullseye

RUN apt-get update -y \
  && apt-get install -y curl php-fpm php-mysql \
  && rm -rf /var/lib/apt/lists/*

COPY ./scripts/entrypoint.sh

RUN chmod 0777 /entrypoint.sh

CMD ["/entrypoint.sh"]
