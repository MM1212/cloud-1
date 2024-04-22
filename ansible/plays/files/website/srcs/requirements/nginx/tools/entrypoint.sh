#!/bin/sh

SSL_PATH=/etc/letsencrypt/live/$DOMAIN_NAME

echo "
server {
  listen 443 ssl default_server;
  listen [::]:443 ssl default_server;
  server_name $DOMAIN_NAME;

  ssl_certificate $SSL_PATH/fullchain.pem;
  ssl_certificate_key $SSL_PATH/privkey.pem;
  ssl_protocols TLSv1.3;

  index index.php index.htm index.html;
  root /var/www/html/;

  location ~ \.php$ {
    try_files \$uri /index.php =404;
    fastcgi_split_path_info ^(.+\.php)(/.+)$;
    fastcgi_pass wordpress:9000;
    fastcgi_index index.php;
    fastcgi_param SCRIPT_FILENAME \$document_root\$fastcgi_script_name;
    include fastcgi_params;
  }
}
server {
  listen 8080 ssl;
  listen [::]:8080 ssl;
  server_name $DOMAIN_NAME;

  ssl_certificate $SSL_PATH/fullchain.pem;
  ssl_certificate_key $SSL_PATH/privkey.pem;
  ssl_protocols TLSv1.3;

  index index.php index.htm index.html;
  location / {
    proxy_pass http://phpmyadmin:80;
    proxy_redirect off;
    proxy_set_header Host \$host;
    proxy_set_header X-Real-IP \$remote_addr;
    proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
    proxy_set_header X-Forwarded-Proto \$scheme;
  }
}
" > /etc/nginx/sites-available/default;

exec nginx -g 'daemon off;'