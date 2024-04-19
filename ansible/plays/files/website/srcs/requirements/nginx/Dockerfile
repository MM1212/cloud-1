FROM debian:bullseye-slim

# Update package lists and install packages
RUN apt-get update && \
  apt-get install nginx wget -yq && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Copy Nginx configuration
COPY conf/nginx.conf /etc/nginx/sites-available/default
COPY tools/entrypoint.sh /tmp/tools/entrypoint.sh

RUN chmod +x /tmp/tools/entrypoint.sh

ENTRYPOINT [ "/tmp/tools/entrypoint.sh" ]