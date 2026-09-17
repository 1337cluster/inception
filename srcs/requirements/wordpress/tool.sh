#!/bin/sh

sleep 2

cd /var/www/html

if [ ! -f wp-config.php ]; then
    echo "Installing WordPress..."
    
    wp core download --allow-root --path=/var/www/html

wp config create --allow-root --path=/var/www/html --skip-check \
        --dbname="$DB_NAME" \
        --dbuser="$DB_USER" \
        --dbpass="$(cat /run/secrets/db_password)" \
        --dbhost="mariadb:3306"

    # Added critical space right before the backslash \
    wp core install --allow-root --path=/var/www/html \
        --url="https://$DOMAIN_NAME" \
        --title="$Inception" \
        --admin_user="$WP_ADMIN_USER" \
        --admin_password="$WP_ADMIN_PASSWORD" \
        --admin_email="$WP_ADMIN_EMAIL" \
        --skip-email

    wp user create "$WP_USER" "$WP_EMAIL" --path=/var/www/html --role=author \
        --user_pass="$WP_PASSWORD" --allow-root
        

    chown -R www-data:www-data /var/www/html

    echo "WordPress installed successfully!"
fi

exec /usr/sbin/php-fpm8.2 -F
