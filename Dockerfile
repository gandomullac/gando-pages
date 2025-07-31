# Dockerfile

# Utilizza un'immagine Nginx ufficiale e leggera basata su Alpine Linux come base.
FROM nginx:alpine

# Installa 'gettext' (per 'envsubst') e 'openssl' per la generazione dei certificati a runtime.
RUN apk add --no-cache gettext openssl

# Copia il template della configurazione di Nginx.
COPY docker/nginx/default.conf.template /etc/nginx/templates/default.conf.template

# Copia gli script di avvio nel container.
COPY docker/nginx/entrypoint.sh /docker-entrypoint.sh
COPY docker/nginx/generate-certs.sh /usr/local/bin/generate-certs.sh

# Rendi gli script eseguibili.
RUN chmod +x /docker-entrypoint.sh /usr/local/bin/generate-certs.sh

# Imposta il nostro script personalizzato come entrypoint del container.
ENTRYPOINT ["/docker-entrypoint.sh"]

# Copia i file del sito web.
COPY dist/ /usr/share/nginx/html/
# Imposta i permessi corretti per l'utente nginx.
RUN chown -R nginx:nginx /usr/share/nginx/html

# Specifica il comando di default da passare al nostro entrypoint.
# Questo avvia Nginx in primo piano, che è la pratica corretta per i container.
CMD ["nginx", "-g", "daemon off;"]
