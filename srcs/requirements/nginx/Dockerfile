FROM debian:bullseye

# update our list & install nginx
RUN apt-get update 
RUN apt-get install nginx -y

# copy our config and script over
COPY ./conf /etc/nginx/nginx.conf
COPY ./tools/script.sh /

# change our script permissions
RUN chmod +x /script.sh

# run our script during runtime
ENTRYPOINT ["/script.sh"]
