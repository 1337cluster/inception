DC = docker compose -f srcs/docker-compose.yml
DATA = /home/h-el-ahr/data

all: up

up:
	mkdir -p $(DATA)/mysql $(DATA)/wordpress
	$(DC) up -d --build

down start stop:
	$(DC) $@

clean:
	$(DC) down --rmi all --remove-orphans

fclean:
	$(DC) down --rmi all --volumes --remove-orphans

re: fclean
	$(MAKE) all

.PHONY: all up down start stop clean fclean re