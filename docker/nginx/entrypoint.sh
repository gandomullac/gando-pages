#!/bin/sh
set -e

/usr/local/bin/generate-certs.sh

envsubst '${DOMAIN_NAME}' < /etc/nginx/templates/default.conf.template > /etc/nginx/conf.d/default.conf

exec "$@"
