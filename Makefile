.SILENT:
COMPOSE_FILE = srcs/docker-compose.yml
DATA_PATH = /home/${USER}/data

all: setup up

setup:
	@mkdir -p ${DATA_PATH}/wordpress
	@mkdir -p ${DATA_PATH}/mariadb
	@mkdir -p secrets

	@if [ ! -f secrets/db_root_password.txt ]; then \
		openssl rand -base64 32 > secrets/db_root_password.txt; \
	fi

	@if [ ! -f secrets/db_password.txt ]; then \
		openssl rand -base64 32 > secrets/db_password.txt; \
	fi

	@if [ ! -f secrets/wp_admin_password.txt ]; then \
		openssl rand -base64 32 > secrets/wp_admin_password.txt; \
	fi

	@if [ ! -f secrets/wp_user_password.txt ]; then \
		openssl rand -base64 32 > secrets/wp_user_password.txt; \
	fi

up:
	docker compose -f ${COMPOSE_FILE} up -d --build

down:
	docker compose -f ${COMPOSE_FILE} down

clean: down
	docker system prune -af

fclean:
	docker compose -f ${COMPOSE_FILE} down -v
	docker system prune -af
	sudo rm -rf ${DATA_PATH}
	rm -rf secrets

re: fclean all

.PHONY: all setup up down clean fclean re
