#!/bin/bash

# Ensure runtime directories exist with proper permissions
mkdir -p /run/mysqld
chown -R mysql:mysql /run/mysqld
chown -R mysql:mysql /var/lib/mysql

# 1. Start MariaDB temporarily in the background
mysqld &

# 2. Wait for it to be completely ready
until mysqladmin ping --silent; do 
    sleep 1
done

# 3. Read secrets safely
MYSQL_PASSWORD=$(cat /run/secrets/db_password)
MYSQL_ROOT_PASSWORD=$(cat /run/secrets/db_root_password)

# 4. Secure the installation and create the database/user
# Note: Fixed the syntax typos on DB_USER and MYSQL_PASSWORD lines below
mysql -u root <<EOF
CREATE DATABASE IF NOT EXISTS \`${DB_NAME}\`;
CREATE USER IF NOT EXISTS '\({DB_USER}'@'\%' IDENTIFIED BY '\){MYSQL_PASSWORD}';
GRANT ALL PRIVILEGES ON \`${DB_NAME}\`.* TO '\${DB_USER}'@'%';
ALTER USER 'root'@'localhost' IDENTIFIED BY '\${MYSQL_ROOT_PASSWORD}';
DELETE FROM mysql.user WHERE User='';
FLUSH PRIVILEGES;
EOF

echo "Database initialization complete. Stopping temporary instance..."

# 5. Cleanly stop the background process to release the file locks!
mysqladmin -u root -p"\${MYSQL_ROOT_PASSWORD}" shutdown

echo "Launching MariaDB in foreground..."

# 6. Safely execute MariaDB as the main foreground process
exec mysqld
