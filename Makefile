DOCKER_COMPOSE = docker compose -f srcs/docker-compose.yml

DATA_PATH  =  /home/h-el-ahr/data
all: up

up:
		@mkdir  -p $(DATA_PATH)/mysql
		@mkdir -p $(DATA_PATH)/wordpress
		$(DOCKER_COMPOSE) up --build -d
		$(DOCKER_COMPOSE) up -d --build

down:
		$(DOCKER_COMPOSE) downz

start:
		$(DOCKER_COMPOSE) start

stop:
		$(DOCKER_COMPOSE) stop


clean:
	docker stop $$(docker ps -qa) 2>/dev/null || true
	docker rm $$(docker ps -qa) 2>/dev/null || true
	docker rmi -f $$(docker images -qa) 2>/dev/null || true
	docker volume rm $$(docker volume ls -q) 2>/dev/null || true
	docker network prune -f 2>/dev/null || true

fclean: clean
	docker system prune --all --force --volumes
re: fclean all

.PHONY: all up down start stop clean fclean re