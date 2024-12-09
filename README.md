# SAE Dolibarr

### Dolibarr

Dolibarr est un ERP open source lancé en 2003, conçu pour les petites et moyennes entreprises. Il permet de gérer des fonctions variées comme la comptabilité et les ventes, avec une interface modulaire. Bien que gratuit, il offre des services de support payants via des sociétés partenaires. Ses points forts incluent sa flexibilité et sa simplicité, mais son interface peut sembler vieillotte. Face à des concurrents comme **Odoo** ou **ERPNext**, Dolibarr reste une option économique, bien qu'il soit moins sophistiqué.

### Description du projet

Le but de cette SAE est de mettre en place l'ERP Dolibarr sous Docker et créer des scripts pour faciliter son déploiement et la sauvegarde de l'ERP.


---

### Arborescence du projet

Notre solution est composée d'un **docker-compose** décrivant le conteneur Dolibarr et sa base de données.

Nous avons également créé plusieurs **scripts utilitaires** pour :
- Faire une **sauvegarde** de la base de données Dolibarr : `dump_database.sh`.
- **Restaurer** la base de données depuis une sauvegarde : `restore_database.sh`.
- **Importer** des données au format CSV dans Dolibarr : `import_csv.py`.


### Arborescence du projet
```
.
├── suivi_projet.md
├── README.md
│
├── backups  // dumps de BDD, partagé avec Dolibarr
│   ├── dump_first_install.sql
│   ├── dump_database_20241204_1626.sql
│   └── dump_database_20241204_1636.sql.bz2
│
├── docker
│   ├── default.env
│   ├── docker-compose.yml
│   └── Makefile
│
├── scripts  // scripts utilitaires
│   ├── dump_database.sh
│   ├── restore_database.sh
│   └── import_csv.py
│
├── imports  // dossier partagé avec Dolibarr
│   └── test_users.csv
│
└── documentation
```

---

## Installation et Procédures

L'installation du projet se fait à l'aide de la [Procédure de première installation](./documentation/procedure_premiere_install.md), il est également possible de customiser l'installation.

TL;DR
```
cd docker
make install
-> se connecter http://localhost:80/
```

### Liste des autres procédures
- [Procédure de sauvegarde & restauration](./documentation/procedure_sauvegarde_restauration.md)
- [Procédure d'import de données CSV](./documentation/import_donnee_csv.md)


## ⚠️ Test du POC (backup, restore, import)

Pour tester chaque fonctionnalité du POC, nous vous proposons de suivre les étapes suivantes à l'aide de cette [**procédure de test du POC**](./documentation/procedure_POC.md).

Les étapes sont dans un ordre qui permet de tester les différentes parties du POC :
1. **Installation préconfigurée** (nom entreprise, login admin, etc).
2. **Import d'un dump de test** qui activera des modules et des données de tests. **Étape obligatoire pour la suite** (sinon le script d'import CSV ne pourra pas insérer de données car le token API ne sera pas créé).
3. **Import de données depuis un fichier CSV**.
4. **Sauvegarde d'un dump de la DB**.
5. **Suppression des containers et données liés**.
6. **Réstauration de Dolibarr depuis le backup effectué**.

---

## Étapes du projet

#### Étapes > Première prise en main

Une première prise en utilisant une image Docker fournie sur le GitHub de Dolibarr. Plusieurs modules ont été testés : RH, User & Group, et des données de test y ont été insérées.
Ensuite, en se connectant à la base de données, les tables et les colonnes relatives aux données de test insérées précédemment ont été identifiées.

---

#### Étapes > Installation manuelle

Notre but étant de créer notre propre image Dolibarr en partant d'un Ubuntu vierge, il est nécessaire d'installer une première fois manuellement Dolibarr en **prenant note de chaque étape** nécessaire pour l'**automatiser**.
Une fois l'installation terminée, nous avons pu créer deux scripts, l'un installant Dolibarr, l'autre configurant MySQL.

**Script install_dolibarr.sh :** Ce script télécharge Dolibarr depuis le repo GitHub et l'installe.
**Script install_mysql.sh :** Ce script définit un mot de passe pour le compte root MySQL, configure MySQL et crée l'utilisateur Dolibarr avec base de données.

---


#### Étapes > Création d'un Dockerfile Dolibarr

Le Dockerfile nous permet de créer notre **image Docker custom**, c'est-à-dire que nous partons d'une image Ubuntu et installons nous-mêmes les middlewares, dépendances, Dolibarr et sa base de données.

Cette approche nous permet d'avoir un **controlle total sur l'installation** et de savoir comment le conteneur fonctionne.

Les middlewares Apache, PHP et MySQL sont installés depuis le Dockerfile, et les deux scripts d'installations de Dolibarr et MySQL sont lancés dans le Dockerfile à la création de l'image.

Nous utilisons un docker-compose pour build et lancer l'image Docker. Une fois le conteneur build et lancé, nous pouvons nous rendre sur la page web et configurer Dolibarr.

Mais une fois la configuration terminée, une **message d'erreur** survient, nous prévenant que la **DB n'est pas joignable**.

Après plusieurs approches de corrections de l'erreur, il ne nous était pas possible de passer outre cette erreur.
Nous avons donc pris la décision d'abandonner cette approche, pour partir de l'image Docker Dolibarr officielle pour continuer le projet.

---


#### Étapes > Plan B

Notre nouvelle approche pour continuer le projet est de recommencer en **utilisant l'image Docker fournie par Dolibarr**.
Dolibarr fournit dans sa documentation un docker-compose créant deux conteneurs, le service web Dolibarr ainsi que sa base de données.

Une fois le docker-compose lancé, nous avons accès à l'interface web Dolibarr, préconfigurée avec les variables renseignées dans le docker-compose.

Dolibarr étant fonctionnel, nous pouvons commencer la création des scripts utilitaires de sauvegarde/restauration et d'import de données depuis un fichier CSV.

---


#### Étapes > Script de sauvegarde
Le script de sauvegarde `dump_database.sh` nous permet de faire un **dump complet** de la DB Dolibarr au **format texte** (.sql) **ou compressé** (.bz2).

Le script est configurable à l'aide de variables pour définir, le user, password, database, la compression du fichier, etc.

La sauvegarde est faite dans le dossier **`backups`** et contient la date de sauvegarde dans le nom. ex: `dump_database_20241204_1626.sql`

**Fonctionnement :** Le script est à lancer depuis la machine hôte et se connectera au conteneur Dolibarr web pour lancer la commande de dump sur la base de données. 

La commande sauvegarde le dump dans le dossier `/backups` du conteneur, ce dossier est un volume partagé sur l'hôte (database_backups).
Le fichier dump étant créé par l'utilisateur `root` du conteneur, il est nécessaire de changer l'appartenance du fichier pour être modifiable et supprimable sur la machine hôte. Le script fait donc ensuite un `chown` sur les sauvegardes avec l'ID et GID de l'utilisateur de la machine hôte.

---


#### Étapes > Script de restauration

Le script de restauration permet de **réstaurer** la DB depuis un **dump précédent**.

**Fonctionnement :** Le script est à **lancer depuis la machine hôte** et se connectera au conteneur Dolibarr web pour lancer la commande d'ajout des données à la base de données.


#### Étapes > Script d'import de données

Le script d'import de données est un **POC** démontrant la possibilité du parsing de fichiers CSV pour insérer des données dans Dolibarr.

Les données pour chaque utilisateur sont les suivantes : **nom, prenom, email, login, password**

**Fonctionnement :** Le script **utilise l'API REST** de Dolibarr pour créer de nouveaux utilisateurs avec les informations renseignées dans le fichier.
Le script nécessite une clé API qu'il est possible de créer en : activant le module API, puis créer un nouvel utilisateur avec droits admins, puis générer un token API pour l'utilisateur.


---


### Choix techniques et Difficultés

#### Méthode de déploiement

Nous avons exploré plusieurs méthodes de déploiement de Dolibarr afin d'évaluer la meilleure.
Les méthodes étaient :
- Dolideb : Paquet debian Dolibarr censé fonctionner après installation, ce n'était pas le cas.
- Image Docker officielle : Fourni avec un docker-compose, Dolibarr fonctionne parfaitement au premier lancement.
- Création d'une image Docker : Approche la plus complexe mais qui permet d'apprendre beaucoup plus de choses. C'est l'approche avec laquelle nous sommes partis. 


##### Dockerfile

Au départ, nous sommes partis sur la création d'une image Docker custom avec notre installation de Dolibarr, ce qui n'a pas fonctionné car Dolibarr n'arrivait pas à joindre la DB, malgré que nous pouvions la joindre depuis le conteneur Dolibarr web.

Nous avons essayé beaucoup de pistes sans succès :
- Laisser l'installateur Dolibarr créer l'utilisateur et la DB
- Créer la DB et l'utilisateur au préalable
- Créer la DB avec le compte root ou utilisateur
- Autoriser les connexions à MySQL avec le compte utilisateur depuis toute @IP
- Exposer le port MySQL du conteneur
- Pistes sur le forum Dolibarr
- ...

Nous avons donc abandonné cette approche pour partir sur une image Dolibarr officielle.

---

#### Scripts de sauvegarde, restauration et import de données

Nous avons construit nos scripts de manière à être exécutés en dehors du conteneur pour plus de simplicité. Les scripts permettent d'exécuter des commandes à l'intérieur des conteneurs à l'aide de `docker exec`.


---

#### Script import de données CSV

Initialement, nous avons choisi de faire des requêtes SQL pour importer les données dans la BDD. Les données étaient bien insérées dans la BDD mais n'apparaissaient pas dans Dolibarr.

Nous avons ensuite fait des tests d'insertion de données via l'API. Ces derniers ayant été concluants, nous avons gardé cette méthode.

Nous avons choisi de réaliser le script en Python car le langage est plus simple à utiliser pour les tâches de traitement de données comme ce script.


### Générations de données de tests

Les données de tests ont été générées par ChatGPT avec le prompt suivant :
```text
Génère en français une liste de 20 noms/prénoms de personnes fictives qui font un jeu de mots marrant.
Mets-les au format CSV en ajoutant des données, voici la structure du fichier :
login=jean.nemar
password=<génère un mot de passe>
firstname=Jean
lastname=Némar
email=jean.nemar@meg.corp
```

La qualité des données est correcte car c'est un fichier assez simple avec peu de colonnes, il est en revanche compliqué d'avoir un résultat fiable avec un fichier de plusieurs dizaines de colonnes.

### Axes d'améliorations

- Mettre le choix de la compression ou non en argument du script "dump_database.sh" plutôt que de devoir  modifier la valeur de la variable dans le script.

- Un cron job qui lancera des backup quotidienne de la DB.
 
---

# Auteurs

<table>
    <tr>
        <th>
            <div>
                <a href="https://github.com/MaximeSahuc"><img src="https://avatars.githubusercontent.com/u/84405949?s=256" width="48" /></a>
                <br>
                <a href="https://github.com/MaximeSahuc">@MaximeSahuc</a>
            </div>
        </th>
        <th>
            <div>
                 <a href="https://github.com/marccambon"><img src="https://avatars.githubusercontent.com/u/160885185?s=256" width="48" /></a>
                 <br>
                 <a href="https://github.com/marccambon">@marccambon</a>
            </div>
        </th>
    </tr>
</table>
