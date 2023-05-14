cd /var/www/html
if [ -f wp-config.php ]; then
  echo "wp-config.php already exists, skipping creation..."
else
  counter=1
  while [ $counter -le 20 ]
  do
    if  wp config create --dbname="$WORDPRESS_DB_NAME" --dbuser="$WORDPRESS_DB_USER" --dbpass="$WORDPRESS_DB_PASSWORD" --dbhost="$WORDPRESS_DB_HOST" > /dev/null 2>&1; then
      break;
    fi
    echo "Retrying wp config creation..."
    sleep 0.5
  done
fi

wp core install --url=sgamraou.42.fr --title=ainz --admin_user="$ADMIN_USER" --admin_password="$ADMIN_PASSWORD" --admin_email="$ADMIN_EMAIL" --skip-email

exec php-fpm7 -F
