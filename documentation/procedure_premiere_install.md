# Procédure de première installation

## Modifier le fichier default.env

Le fichier .env permet de paramètrer les configurations de base comme les indentifiants de connexions, le nom de l'entreprise et l'URL.
```
    DOLI_ADMIN_LOGIN=admin
    DOLI_ADMIN_PASSWORD=sae52
    DOLI_COMPANY_NAME=MegCorporation
    DOLI_URL_ROOT=http://0.0.0.0
    DOLI_INIT_DEMO=0
```

## Déploiment du projet avec le docker compose

```bash
    cd docker
    make
```

## Utilisation

Se connecter a l'interface web http://0.0.0.0:80

Utiliser les identifiants de connexion suivant:

- Login:admin
- Password:sae52

Dans ce cas Dolibarr sera vierge et nécessitera d'être configurer


