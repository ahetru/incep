#!/bin/bash

set -e

# Lire les secrets
DB_PASSWORD=$(cat /run/secrets/db_password)
WP_ADMIN_PASSWORD=$(cat /run/secrets/wp_admin_password)
WP_USER_PASSWORD=$(cat /run/secrets/wp_user_password)

echo "Attente de MariaDB..."
while ! mysqladmin ping -h"${DB_HOST%:*}" -P"${DB_HOST#*:}" --silent; do
    sleep 1
done

echo "MariaDB est prêt!"

# Télécharger WordPress si nécessaire
if [ ! -f ${WP_PATH}/wp-config.php ]; then
    echo "Installation de WordPress..."
    
    cd ${WP_PATH}
    
    # Télécharger WordPress
    wp core download --allow-root
    
    # Créer wp-config.php
    wp config create \
        --dbname=${MYSQL_DATABASE} \
        --dbuser=${MYSQL_USER} \
        --dbpass=${DB_PASSWORD} \
        --dbhost=${DB_HOST} \
        --allow-root
    
    # Installer WordPress
    wp core install \
        --url=https://${DOMAIN_NAME} \
        --title="${WP_TITLE}" \
        --admin_user=${WP_ADMIN_USER} \
        --admin_password=${WP_ADMIN_PASSWORD} \
        --admin_email=${WP_ADMIN_EMAIL} \
        --allow-root
    
    # Créer un utilisateur supplémentaire
    wp user create ${WP_USER} ${WP_USER_EMAIL} \
        --role=editor \
        --user_pass=${WP_USER_PASSWORD} \
        --allow-root
    
    echo "WordPress installé avec succès!"
fi

# Démarrer PHP-FPM
exec php-fpm8.2 -F
