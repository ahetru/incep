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
	@if [ ! -f secrets/credentials.txt ]; then \
		echo "wp_admin_user=wpadmin" > secrets/credentials.txt; \
		echo "wp_admin_pass=$$(openssl rand -base64 32)" >> secrets/credentials.txt; \
	fi

up:
	docker compose -f ${COMPOSE_FILE} up -d --build

down:
	docker compose -f ${COMPOSE_FILE} down

stop:
	docker compose -f ${COMPOSE_FILE} stop

start:
	docker compose -f ${COMPOSE_FILE} start

logs:
	docker compose -f ${COMPOSE_FILE} logs -f

clean: down
	docker system prune -af --volumes

fclean:
ifndef CONFIRM
$(error fclean is destructive, restart command with `make flcean CONFIRM=yes`)
endif
	$(MAKE) clean
	sudo rm -rf ${DATA_PATH}/wordpress/*
	sudo rm -rf ${DATA_PATH}/mariadb/*
	rm -rf secrets

re: fclean all

.PHONY: all setup up down stop start logs clean fclean re
