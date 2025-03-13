FROM debian:bullseye

# update the list of package that we can install & install php-fpm & php-mysql for wp cli we will install later
RUN apt-get update -y \
  && apt-get install -y curl php-fpm php-mysql \
  && rm -rf /var/lib/apt/lists/*

# copy our local entrypoint.sh into the docker container
COPY ./tools/entrypoint.sh /

# modify the permissions so that we can execute it
RUN chmod 0777 /entrypoint.sh

# make sure these directories exist
RUN mkdir /var/www
RUN mkdir /var/www/html

# clean anything in these directory if there was a previous instance that did not clean up properly
RUN rm -rf /var/www/html/*

# download the latest wp cli
RUN curl -o /var/www/html/wp-cli.phar https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

# modify the permissions so that we can run it
RUN chmod +x /var/www/html/wp-cli.phar

# move the cli into the user local path which then can use as a command
RUN mv /var/www/html/wp-cli.phar /usr/local/bin/wp

# find safer method if possible
RUN wp core download --allow-root --path=/var/www/html/

# copy our website logo over :p
COPY ./tools/favicon.ico /var/www/html

CMD ["/entrypoint.sh"]
