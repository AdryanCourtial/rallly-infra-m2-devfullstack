# Infrastructure Rallly — M2 DevFullstack

Ce dépôt contient l'infrastructure Docker du projet **Rallly**, réalisé dans le cadre du module *Dev avec Docker* (2026-2027).

La documentation principale du projet se trouve dans le [fork Rallly](https://github.com/Rally-Ynov/fork-rallly-m2-devfullstack).

## Technologies

- **Docker Compose** : orchestration des services
- **Caddy** : reverse proxy
- **Authentik** : authentification SSO avec OAuth2/OIDC
- **Rallly** : application de création de sondages
- **PostgreSQL** : base de données
- **Redis** : service de cache

## Prérequis

- Un environnement Linux
- Docker et Docker Compose
- Un accès au réseau NetBird pour la VM de démonstration

## Configuration

Cloner le dépôt :

```bash
git clone https://github.com/AdryanCourtial/rallly-infra-m2-devfullstack.git
cd rallly-infra-m2-devfullstack
```

Créer le fichier d'environnement à partir de l'exemple :

```bash
cp .env.exemple .env
```

Renseigner les variables nécessaires dans `.env` et configurer les services Authentik et Caddy selon l'environnement utilisé.

Les fichiers contenant des secrets ne doivent pas être commités.

## Démarrage

Pour démarrer l'infrastructure :

```bash
bash ./start.sh
```

Ce script démarre les services Rallly, Authentik et Caddy avec Docker Compose.

Pour vérifier les conteneurs Rallly :

```bash
docker compose ps
```

## Déploiement

L'application Rallly est construite et publiée sur GitHub Container Registry via GitHub Actions.

Pour mettre à jour uniquement le conteneur Rallly :

```bash
bash ./start.sh deploy
```

Cette commande récupère la dernière image et recrée le conteneur applicatif sans redémarrer ses dépendances.

## Authentification et sécurité

L'accès à Rallly utilise Authentik comme fournisseur d'identité OIDC.

Deux groupes permettent de contrôler l'accès :
- `rallly-users` : accès autorisé à Rallly
- `rallly-blocked` : accès refusé

Un parcours d'invitation permet également de créer des comptes externes avec une politique de mot de passe, une attribution automatique au groupe autorisé et une redirection vers Rallly.

Les services sont accessibles via Caddy. La base PostgreSQL est limitée à l'interface locale de la VM et Redis n'expose pas de port sur l'hôte.

## Accès à la démonstration

Sur le réseau NetBird de la VM :

- **Rallly** : http://10.2.192.11:8080
- **Authentik** : http://10.2.192.11:8081

Ces adresses correspondent à l'environnement de démonstration et ne sont pas des URL publiques.

## Dépôt applicatif

Code source, fonctionnalités développées et documentation principale :

https://github.com/Rally-Ynov/fork-rallly-m2-devfullstack
