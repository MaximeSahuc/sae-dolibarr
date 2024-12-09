# Procédure POC

### 1. Installation
Lancer la première installation et vérifier que l'instance Dolibarr vierge est bien fonctionnelle.
```bash
cd docker
make install
```

Pour l'instant uniquement **le stric minimum est configuré** (nom d'entreprise, connexion à la database, login admin).

Se connecter et vérifier : http://localhost:80/
<br>
Login: `admin`
<br>
Password: `sae52`

### 2. Import d'un dump de test
Importer ensuite le dump SQL fourni dans `backups/dump_first_install.sql` à l'aide du script de restauration.

**Les containers doivent être en cours d'execution** pour importer les données.
```bash
cd scripts
./restore_database.sh ../backups/dump_first_install.sql
```

output:
```bash
Restoring database from dump_first_install.sql
Success: database retored from dump_first_install.sql
```

Se connecter à nouveau et vérifier que les données ont été insérées.
Se rendre sur la [page des utilisateurs](http://localhost/user/list.php?leftmenu=users), nous pouvons voir que le user admin 'csv import user' à été créé, il permettra d'importer les données CSV via l'API Dolibarr.


### 3. Import de données via fichier CSV
Exécuter le script "import_csv.py" avec le fichier CSV en argument.
Il permet de créer les utilisateurs contenus dans le fichier CSV.

```bash
cd scripts
./import_csv.py ../imports/test_users.csv
```

En actualisant la page des utilisateurs, nous pouvons voir que les utilisateurs ont été créés.


### 4. Dump de la database
Nous allons maintenant créer un dump de la database avant de tout supprimer, et restaurer depuis cette sauvegarde.

La sauvegarde s'effectue en faisant un dump de la base de donnée 'dolidb'.

Exécuter le script `dump_database.sh`

```bash
cd scripts
./dump_database.sh
```

output:
```bash
Dumping database: dolidb
Success: Saved file to dump_database_20241209_2338.sql
```

### 5. Destruction et re-création de Dolibarr
Une fois la sauvegarde faite, nous pouvons supprimer les containers ainsi que les données de Dolibarr.

```bash
cd docker
make rm
```

##### *Les backups et fichiers CSV ne sont pas supprimés.*

### 6. Restauration depuis la sauvegarde

Lancer la commande de première installation et vérifier que l'instance Dolibarr vierge est bien fonctionnelle.
```bash
cd docker
make install
```

Se connecter à Dolibarr et vérifier qu'uniquement **le stric minimum est configuré** (nom d'entreprise, connexion à la database, login admin).

Ensuite, importer ensuite le backup effectué à l'aide du script de restauration.

##### *Les containers doivent être en cours d'execution*

```bash
cd scripts
./restore_database.sh ../backups/dump_database_xxx.sql
```

output:
```bash
Restoring database from dump_database_20241209_2338.sql
Success: database retored from dump_database_20241209_2338.sql
```

Se connecter à Dolibarr et vérifier que les utilisateurs importés avant la sauvegarde sont bien présents.

Fin!