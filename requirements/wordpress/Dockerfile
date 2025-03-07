FROM debian:bullseye

RUN apt-get update -y \
  && apt-get install -y curl php-fpm php-mysql \
  && rm -rf /var/lib/apt/lists/*

COPY ./scripts/entrypoint.sh /

RUN chmod 0777 /entrypoint.sh


RUN mkdir /var/www
RUN mkdir /var/www/html

RUN rm -rf /var/www/html/*

RUN curl -o /var/www/html/wp-cli.phar https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

RUN chmod +x /var/www/html/wp-cli.phar

RUN mv /var/www/html/wp-cli.phar /usr/local/bin/wp

# find safer method if possible
RUN wp core download --allow-root --path=/var/www/html/

CMD ["tail", "-f", "/dev/null"]
#CMD ["/entrypoint.sh"]
