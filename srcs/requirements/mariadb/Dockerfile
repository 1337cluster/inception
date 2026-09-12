FROM debian:bookworm

RUN apt-get update && apt-get install -y mariadb-server  \
    && rm -rf /var/lib/apt/lists/*

COPY mariadb.conf mariadb.conf 

COPY tool.sh tool.sh

RUN chmod +x tool.sh 

EXPOSE 3306

ENTRYPOINT ["tool.sh"]