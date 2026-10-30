#!/bin/bash
set -e

echo "Démarrage d'Authentik..."
docker compose \
  --project-directory authentik \
  -f authentik/compose.yml \
  up -d

echo "Démarrage de Rallly..."
docker compose -f compose.yml up -d

echo "Infrastructure démarrée."