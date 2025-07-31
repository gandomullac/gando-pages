#!/bin/sh
# Uscire immediatamente se un comando fallisce.
set -e

# Controlla se DOMAIN_NAME è impostato, altrimenti usa un valore di default.
# La variabile viene passata dal file .env tramite docker-compose.
if [ -z "${DOMAIN_NAME}" ]; then
  echo "Attenzione: La variabile DOMAIN_NAME non è impostata. Uso 'localhost' come default."
  DOMAIN_NAME="localhost"
fi

CERT_DIR="/etc/nginx/certs"
KEY_FILE="${CERT_DIR}/privkey.pem"
CERT_FILE="${CERT_DIR}/fullchain.pem"

# Controlla se i certificati esistono già nella directory montata.
# Se non esistono, li genera.
if [ -f "$KEY_FILE" ] && [ -f "$CERT_FILE" ]; then
  echo "I certificati SSL esistono già. Salto la generazione."
else
  echo "Generazione dei certificati SSL auto-firmati per ${DOMAIN_NAME}..."

  # Crea la directory se non esiste (dovrebbe già esistere grazie al volume mount).
  mkdir -p "$CERT_DIR"

  # Genera la chiave privata e il certificato.
  openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout "$KEY_FILE" \
    -out "$CERT_FILE" \
    -subj "/C=IT/ST=Local/L=Local/O=LocalDev/CN=${DOMAIN_NAME}"

  echo "Certificati generati con successo in ${CERT_DIR}."
fi
