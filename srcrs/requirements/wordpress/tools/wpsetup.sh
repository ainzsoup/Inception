cd /var/www/html

if [ -f wp-config.php ]; then
  echo "wp-config.php already exists, skipping creation..."
else
  wp config create --dbname="$WORDPRESS_DB_NAME" --dbuser="$WORDPRESS_DB_USER" --dbpass="$WORDPRESS_DB_PASSWORD" --dbhost="$WORDPRESS_DB_HOST"
fi

wp core install --url=sgamraou.42.fr --title=ainz --admin_user="$ADMIN_USER" --admin_password="$ADMIN_PASSWORD" --admin_email="$ADMIN_EMAIL" --skip-email

exec php-fpm7 -F
