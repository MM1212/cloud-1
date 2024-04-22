#!/bin/sh

if [ -d "/var/lib/mysql/$DB_NAME" ]
then 
	echo "Database already exists"
else
service mariadb start
# Set root option so that connexion without root password is not possible

#Create database and user for wordpress
echo "CREATE USER '$DB_USER'@'%' IDENTIFIED BY '$DB_PASSWORD';" | mariadb -uroot
echo "CREATE DATABASE IF NOT EXISTS $DB_NAME; GRANT ALL ON $DB_NAME.* TO '$DB_USER'@'%' IDENTIFIED BY '$DB_PASSWORD'; FLUSH PRIVILEGES;" | mariadb -uroot

# setup root stuff
echo "DELETE FROM mysql.user WHERE User='';" | mariadb -uroot
echo "DROP DATABASE IF EXISTS test;" | mariadb -uroot
echo "DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';" | mariadb -uroot
echo "UPDATE mysql.user set Password=PASSWORD('$DB_ROOT_PASSWORD') where User='root';" | mariadb -uroot
echo "FLUSH PRIVILEGES;" | mariadb -uroot -p$DB_ROOT_PASSWORD

sleep 2
service mariadb stop
sleep 2
fi


exec mysqld_safe --bind-address=0.0.0.0