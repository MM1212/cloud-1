ln -s /etc/letsencrypt/live/$DOMAIN_NAME $ROOT_PATH/certs 

exec "$@"