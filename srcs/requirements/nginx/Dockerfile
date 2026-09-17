FROM debian:bookworm

RUN apt-get update && apt-get install -y nginx openssl \
    && rm -rf /var/lib/apt/lists/*

COPY nginx.conf /etc/nginx/sites-available/default

COPY tool.sh /tool.sh

RUN chmod +x /tool.sh 

EXPOSE 443

ENTRYPOINT ["/tool.sh"]