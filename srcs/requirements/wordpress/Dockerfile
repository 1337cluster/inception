FROM debian:bookworm

RUN apt-get update && apt-get install -y \
    wordpress  \
    php-fpm \
    php-mysqli \
    default-mysql-client \
    && rm -rf /var/lib/apt/lists/*

COPY wordpress.conf wordpress.conf 

COPY tool.sh tool.sh

RUN chmod +x tool.sh 

EXPOSE 9000

ENTRYPOINT ["tool.sh"]