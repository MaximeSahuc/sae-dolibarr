# Procédure sauvegarde & restauration

## Sauvegarde

La sauvegarde s'effectue en faisant un dump de la base de donnée "dolibarr":

Exécuter le script "dump_database.sh"

```bash
cd scripts
./dump_database.sh
```

Cela va générer un fichier .sql

Il est possible de générer un fichier compresser .bz2 en modifiant la variable suivante de false à true

```
DUMP_COMPRESS=true
```

Les fichiers de sauvegardes sont stockés dans le dossier ./docker/dolibarr_backups

## Restauration

Exécuter le script de restauration restore_database.sh avec le chemin du fichier .sql à importer en argument.

```bash
cd scripts
./restore_database.sh <dump.sql>
```

Le script ne supporte pas les fichiers compresser. Il faudra donc décompresser le fichier avant l'import si besoin.