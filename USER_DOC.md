# USER DOCUMENTATION

## Overview

This project provides: - NGINX (HTTPS) - WordPress (PHP-FPM) - MariaDB

------------------------------------------------------------------------

## Start the Project

make

------------------------------------------------------------------------

## Stop the Project

make down

------------------------------------------------------------------------

## Access the Website

https://localhost

Accept the self-signed certificate warning if prompted.

------------------------------------------------------------------------

## WordPress Admin

https://localhost/wp-admin

------------------------------------------------------------------------

## Credentials

Stored in: secrets/

Files: - db_root_password.txt - db_password.txt -
wp_admin_password.txt - wp_user_password.txt

------------------------------------------------------------------------

## Check Running Services

docker ps

View logs: docker logs `<container_name>`

------------------------------------------------------------------------

## Persistent Data

Stored in: /home/ahetru/data/
