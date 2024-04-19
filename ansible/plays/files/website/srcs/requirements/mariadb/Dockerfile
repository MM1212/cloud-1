# # Use the official Debian base image
FROM debian:bullseye-slim

# Install MariaDB and other required packages
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -yq mariadb-server && \ 
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY ./conf/start.sh .
RUN chmod +x ./start.sh

EXPOSE 3306

ENTRYPOINT ./start.sh