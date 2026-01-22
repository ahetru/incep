#!/bin/bash

set -e

# Générer le certificat SSL auto-signé
if [ ! -f /etc/nginx/ssl/certificate.crt ]; then
    echo "Génération du certificat SSL..."
    openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
        -keyout /etc/nginx/ssl/private.key \
        -out /etc/nginx/ssl/certificate.crt \
        -subj "/C=FR/ST=State/L=City/O=42/OU=42/CN=${DOMAIN_NAME}"
fi

# Remplacer les variables d'environnement dans nginx.conf
envsubst '${DOMAIN_NAME}' < /etc/nginx/nginx.conf > /tmp/nginx.conf
mv /tmp/nginx.conf /etc/nginx/nginx.conf

echo "NGINX configuré avec succès"

# Démarrer NGINX en mode foreground
exec nginx -g 'daemon off;'
