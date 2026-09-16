#!/bin/bash

mkdir -p /run/mysqld
chown -R mysql:mysql /run/mysqld

mysqld &

until  mysqladmin  ping  --silent ;  do sleep 1;done


MYSQL_PASSWORD=$(cat /run/secrets/db_password)
MYSQL_ROOT_PASSWORD=$(cat  /run/secrets/db_root_password)

mysql -u  root  <<EOF

CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};

CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';

GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';

ALTER  USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';

DELETE  FROM mysql.user WHERE User='';

FLUSH PRIVILEGES;


EOF

mysqladmin  -u  root  -p${MYSQL_ROOT_PASSWORD} shutdown

exec mysqld