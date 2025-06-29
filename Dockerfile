# Dockerfile pour serveur n8n d'entreprise
FROM n8nio/n8n:latest

# Métadonnées
LABEL maintainer="VAplove50@gmail.com"
LABEL description="Serveur d'automatisation n8n pour [WAZ]"
LABEL version="1.0"

# Configuration utilisateur
USER root

# Installation d'outils système si nécessaire
RUN apk add --no-cache \
    su-exec \
    tini

# Retour à l'utilisateur n8n
USER node

# Variables d'environnement par défaut
ENV N8N_PORT=5678
ENV N8N_HOST=0.0.0.0
ENV N8N_PROTOCOL=https
ENV NODE_ENV=production

# Répertoire de travail
WORKDIR /home/node

# Exposition du port
EXPOSE 5678

# Health check pour monitoring
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD wget --no-verbose --tries=1 --spider http://localhost:5678/ || exit 1

# Point d'entrée avec init système
ENTRYPOINT ["tini", "--"]
CMD ["n8n"]
