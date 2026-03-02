# DEVELOPER DOCUMENTATION

## Prerequisites

-   Linux
-   Docker
-   Docker Compose
-   Make

------------------------------------------------------------------------

## Setup From Scratch

make

This will: - Create data directories - Generate secrets - Build images -
Start containers

------------------------------------------------------------------------

## Manual Build

docker compose -f srcs/docker-compose.yml up -d --build

------------------------------------------------------------------------

## Stop

docker compose -f srcs/docker-compose.yml down

------------------------------------------------------------------------

## Remove Volumes

docker compose -f srcs/docker-compose.yml down -v

------------------------------------------------------------------------

## Enter a Container

docker exec -it <container_name> bash

------------------------------------------------------------------------

## Network

Custom bridge network: inception

------------------------------------------------------------------------

## Secrets

Generated in: secrets/

Mounted inside containers at: /run/secrets/

------------------------------------------------------------------------

## Data Persistence

Bind-mounted in: /home/ahetru/data/

-   MariaDB → /home/ahetru/data/mariadb
-   WordPress → /home/ahetru/data/wordpress

------------------------------------------------------------------------

## Rebuild From Scratch

make re
