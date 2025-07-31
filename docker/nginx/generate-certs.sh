#!/bin/sh
set -e

if [ -z "${DOMAIN_NAME}" ]; then
  echo "Domain name variable not set. Using default 'localhost'."
  DOMAIN_NAME="localhost"
fi

CERT_DIR="/etc/nginx/certs"
KEY_FILE="${CERT_DIR}/privkey.pem"
CERT_FILE="${CERT_DIR}/fullchain.pem"

if [ -f "$KEY_FILE" ] && [ -f "$CERT_FILE" ]; then
  echo "SSL certificates already exist for ${DOMAIN_NAME}. Skipping generation."
else
  echo "Generating self-signed SSL certificates for ${DOMAIN_NAME}..."

  mkdir -p "$CERT_DIR"

  openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout "$KEY_FILE" \
    -out "$CERT_FILE" \
    -subj "/C=IT/ST=Local/L=Local/O=LocalDev/CN=${DOMAIN_NAME}"

  echo "Certificates successfully generated in ${CERT_DIR}."
fi
