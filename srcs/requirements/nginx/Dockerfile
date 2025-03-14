FROM debian:bullseye

# update our list & install nginx
RUN apt-get update 
RUN apt-get install nginx -y

# copy our config, script and certs over
COPY ./conf /etc/nginx/nginx.conf
COPY ./tools/* /

# change our script permissions
RUN chmod +x /script.sh

# run our script during runtime
ENTRYPOINT ["/script.sh"]
