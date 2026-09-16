#!/bin/sh

# 1. Ntsnaw MariaDB bma wjdat (Readiness loop)
until mysqladmin ping -h mariadb -u root -p"$(cat /run/secrets/db_root_password)" --silent; do
    echo "Waiting for MariaDB"
    sleep 2
done


# 2. N-téléchargiw w n'instaliw WordPress ila makanch (Configuration)
cd /var/www/wordpress

if [ ! -f wp-config.php ]; then
    echo "Installing WordPress..."
    
    wp core download --allow-root
    wp config create --allow-root \
        --dbname="$DB_NAME" \
        --dbuser="$DB_USER" \
        --dbpass="$(cat /run/secrets/db_password)" \
        --dbhost=mariadb:3306

    wp core install --allow-root \
        --url="https://$DOMAIN_NAME" \
        --title="$WP_TITLE" \
        --admin_user="$WP_ADMIN_USER" \
        --admin_password="$(cat /run/secrets/wp_admin_password)" \
        --admin_email="$WP_ADMIN_EMAIL" \
        --skip-email

    wp user create "$WP_USER" "$WP_USER_EMAIL" --role=author \
        --user_pass="$(cat /run/secrets/wp_user_password)" --allow-root
        
    echo "WordPress installed successfully!"
fi

echo "Starting PHP-FPM in foreground..."

# 3. Nx3lo PHP-FPM f l-Foreground
exec php-fpm7.4 -F