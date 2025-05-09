FROM debian:bullseye

# update the list of package that we can install & install php-fpm & php-mysql for wp cli we will install later
RUN apt-get update -y
RUN apt-get install -y curl php7.4-fpm php-mysql

# make sure these directories exist
RUN mkdir /run/php
RUN mkdir /var/www

# create and modify the permission for the html folder
RUN mkdir /var/www/html
RUN chown :www-data /var/www/html
RUN chmod 775 /var/www/html

# remove existing files if there are any for a clean start
RUN rm -rf /var/www/html/*

# download the latest wp cli
RUN curl -o /var/www/html/wp-cli.phar https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

# modify the permissions so that we can run it
# then move it to user local path where it then can be called like a command
RUN chmod +x /var/www/html/wp-cli.phar
RUN mv /var/www/html/wp-cli.phar /usr/local/bin/wp

# copy our files over & change the permission to make scripts runnable
COPY ./tools/favicon.ico /var/www/html
COPY ./tools/entrypoint.sh ./tools/wp-install-script.sh /
RUN chown :www-data /entrypoint.sh /wp-install-script.sh
RUN chmod 775 /entrypoint.sh /wp-install-script.sh

# change the php-fpm config to listen to port 9000
RUN sed -i 's/listen = \/run\/php\/php7.4-fpm.sock/listen = 0.0.0.0:9000/1' /etc/php/7.4/fpm/pool.d/www.conf

# create a temp user to install the wordpress-cli
RUN useradd -m -s /bin/bash -G sudo,www-data tempUser

# change the working directory to /var/www/html
WORKDIR /var/www/html

ENTRYPOINT ["/entrypoint.sh"]
