FROM alpine:3.14

RUN apk add --no-cache curl php php-phar php-json php-openssl php-mysqli mariadb-client php-mbstring php-fpm \
    && sed -ie "s/listen = .*/listen = 0.0.0.0:9000/" /etc/php7/php-fpm.d/www.conf
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

RUN chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp 

RUN mkdir -p /var/www/html && wp core download --path=/var/www/html 

COPY tools/wpsetup.sh /wpsetup.sh

RUN chmod +x /wpsetup.sh

CMD ["sh", "/wpsetup.sh"]




