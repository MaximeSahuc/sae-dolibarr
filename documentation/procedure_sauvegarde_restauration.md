# Procédure sauvegarde & restauration

## Sauvegarde

La sauvegarde s'effectue en faisant un dump de la base de donnée 'dolidb':

Exécuter le script `dump_database.sh`

```bash
cd scripts
./dump_database.sh
```

Cela va générer un fichier .sql

Il est possible de générer un fichier compressé .bz2 en modifiant la variable suivante.

```
DUMP_COMPRESS=true
```

Les fichiers de sauvegardes sont stockés dans le dossier 'backups'.

## Restauration

Exécuter le script de restauration `restore_database.sh` avec le chemin du fichier .sql à importer en argument.

```bash
cd scripts
./restore_database.sh <dump.sql>
```

Le script ne supporte pas les fichiers compressés. Il faudra donc décompresser le fichier avant l'import, si besoin.