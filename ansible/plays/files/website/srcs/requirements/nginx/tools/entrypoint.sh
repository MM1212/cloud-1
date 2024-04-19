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
" > /etc/nginx/sites-available/default;

exec nginx -g 'daemon off;'