# Procédure de première installation

## Déploiement du projet avec le docker compose

```bash
cd docker
make install
```

Se connecter et vérifier : http://localhost:80/
<br>
Login: `admin`
<br>
Password: `sae52`

## Modifier le fichier default.env (si besoin)

Le fichier .env permet de paramétrer les configurations de base comme les identifiants de connexions, le nom de l'entreprise et l'URL.

```
DOLI_ADMIN_LOGIN=admin
DOLI_ADMIN_PASSWORD=sae52
DOLI_COMPANY_NAME=MegCorporation
DOLI_URL_ROOT=http://0.0.0.0
DOLI_INIT_DEMO=0
```
Il est possible d'activer un mode de démo en mettant la variable DOLI_INIT_DEMO=1 cela activera des modules et insérera des données de test.


## Utilisation

Se connecter a l'interface web à l'URL définie dans le fichier default.env

Dans ce cas, Dolibarr sera vierge et nécessitera d'être configuré

## Arrêt & Suppression

Les conteneurs peuvent être arrêtés avec la commande suivante:

```bash
cd docker
make down
```

Pour arrêter les conteneurs et supprimer tout les fichiers de Dolibarr (sauf backup et imports):

```bash
cd docker
make rm
```

