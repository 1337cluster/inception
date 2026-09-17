FROM debian:bookworm

RUN apt-get update && apt-get install -y \
    wordpress  \
    php-fpm \
    php-mysqli \
    default-mysql-client \
    curl \
    && rm -rf /var/lib/apt/lists/*

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

COPY wordpress.conf /etc/php/8.2/fpm/pool.d/www.conf

COPY tool.sh /tool.sh

RUN chmod +x /tool.sh 

EXPOSE 9000

ENTRYPOINT ["/tool.sh"]