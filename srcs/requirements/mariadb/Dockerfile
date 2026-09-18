FROM debian:bookworm

RUN apt-get update && apt-get install -y mariadb-server  \
    && rm -rf /var/lib/apt/lists/*

COPY mariadb.conf /etc/mysql/mariadb.conf.d/50-server.cnf
RUN chmod 644 /etc/mysql/mariadb.conf.d/50-server.cnf

COPY tool.sh /tool.sh

RUN chmod +x /tool.sh 

EXPOSE 3306

ENTRYPOINT ["/tool.sh"]