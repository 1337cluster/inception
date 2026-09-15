DOCKER_COMPOSE = docker compose -f srcs/docker-compose.yml

all: up

up:
	$(DOCKER_COMPOSE) up -d --build

down:
	$(DOCKER_COMPOSE) down

start:
	$(DOCKER_COMPOSE) start

stop:
	$(DOCKER_COMPOSE) stop

clean: down
	docker system prune -a --volumes -f

fclean: clean

	docker volume rm $$(docker volume ls -q) 2>/dev/null || true


re: fclean all

.PHONY: all up down start stop clean fclean re