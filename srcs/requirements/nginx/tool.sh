#!/bin/bash

if [ ! -f /etc/nginx/ssl/h-el-ahr.42.fr.crt ]; then
    
    mkdir -p /etc/nginx/ssl
    
    openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
        -keyout /etc/nginx/ssl/h-el-ahr.42.fr.key \
        -out /etc/nginx/ssl/h-el-ahr.42.fr.crt \
        -subj "/C=MA/ST=RSK/L=Sale/O=42/OU=1337/CN=h-el-ahr.42.fr"
        
fi

exec nginx -g "daemon off;"