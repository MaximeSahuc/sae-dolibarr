# Procédure de première installation

## Modifier le fichier default.env

Le fichier .env permet de paramètrer les configurations de base comme les indentifiants de connexions, le nom de l'entreprise et l'URL.

```
DOLI_ADMIN_LOGIN=admin
DOLI_ADMIN_PASSWORD=sae52
DOLI_COMPANY_NAME=MegCorporation
DOLI_URL_ROOT=http://0.0.0.0
DOLI_INIT_DEMO=0
```
Il est possible d'activer un mode de demo en mettant la variable DOLI_INIT_DEMO=1 cela activera des modules et insérera des données de test.

## Déploiment du projet avec le docker compose

```bash
cd docker
make
```

## Utilisation

Se connecter a l'interface web à l'URL défini dans le fichier default.env

Dans ce cas Dolibarr sera vierge et nécessitera d'être configuré

## Arrêt & Suppression

Les contenneurs peuvent-être arrêtés avec la commandes suivantes:

```bash
cd docker
make down
```

Pour arrêter les conteneurs et supprimer tout les fichiers de Dolibarr:

```bash
cd docker
make rm
```

