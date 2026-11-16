#!/bin/bash
set -e

cd "$(dirname "$0")"

if [ "${1:-}" = "deploy" ]; then
  echo "Déploiement de Rallly..."

  docker compose -f compose.yml pull rallly_selfhosted

  docker compose -f compose.yml up -d \
    --no-deps \
    --no-build \
    --force-recreate \
    rallly_selfhosted

  echo "Rallly déployé."
  exit 0
fi

echo "Démarrage de Rallly..."
docker compose -f compose.yml up -d

echo "Démarrage d'Authentik..."
docker compose \
  --project-directory authentik \
  -f authentik/compose.yml \
  up -d

echo "Démarrage de Caddy..."
docker compose -f proxy/compose.yml up -d

echo "Infrastructure démarrée."