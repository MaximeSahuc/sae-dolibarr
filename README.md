# SAE Dolibarr


### Description du projet

Le but de cette SAE est de mettre en place l'ERP Dolibarr sous Docker et créer des scripts pour faciliter son déploiement et la sauvegarde de l'ERP.

TODO
- S'intéresser au projet Dolibarr: origine, développement, 
qui-quoi-quand, rythme de release, communauté, évolutions, forums 
(activité?), sociétés fournissant du support, etc.
Points forts/points faible.
Concurrence? (projets libres similaires et/ou produits commerciaux)
Et rédiger un CR sur tout ça.


### Solution

Notre solution est composé d'un docker-compose décrivant le conteneur Dolibarr et sa base de donnée.

Nous avons également crée plusieurs scripts utilitaires pour :
- Faire une sauvegarde de la base de donnée Dolibarr : `dump_database.sh`.
- Restaurer la base de donnée depuis une sauvegarde : `restore_database.sh`.
- Importer des donnée au format CSV dans Dolibarr : `import_csv.sh`.


### Arborescence du projet
```
.
├── suivi-projet.md
├── compte-rendu.md
│
├── database_backups
│   ├── dump_database_20241204_1626.sql
│   └── dump_database_20241204_1636.sql.bz2
│
├── docker
│   └── docker-compose.yml
│
├── scripts
│   ├── dump_database.sh
│   ├── restore_database.sh
│   └── import_csv.sh
│
├── import_data
│   ├── utilisateurs_sample.csv
│   └── facturations_sample.csv
│
└── documentation
```

### Description de la solution



### Étapes du projet

#### Étapes > Première prise en main

Une première prise en utilisant une image docker fourni sur le github de Dolibarr. Plusieurs modules ont été testés: RH, User & Group, et des données de test y ont été inséré.
Ensuite en se connectant à la base de donnée, les tables et les colonnes relatives aux données de test insérés précédemment ont été identifiées.  

---

#### Étapes > Installation manuelle**

Notre but étant de créer notre propre image Dolibarr en partant d'un ubuntu vierge, il est nécessaire d'installer une première fois manuellement Dolibarr en prenant note de chaque étape nécessaire pour l'automatiser.
Une fois l'installation terminée nous avons pu créer deux scripts, l'un installant Dolibarr, l'autre configurant MySQL.

**Script install_dolibarr.sh :** Ce script télécharge Dolibarr depuis le repo GitHub et l'installe.
**Script install_mysql.sh :** Ce script définit un mot de passe pour le compte root MySQL, configure MySQL et crée l'utilisateur Dolibarr avec base de donnée.

---


#### Étapes > Création d'un Dockerfile Dolibarr

Le Dockerfile nous permet de créer notre image Docker custom, c'est à dire que nous partons d'une image ubuntu et installons nous même les middlewares, dépendance, Dolibarr et sa base de donnée.
Cette approche nous permet d'avoir un controlle total sur l'installation et de savoir comment le conteneur fonctionne.
Les middlewares Apache, PHP et MySQL sont installés depuis le Dockerfile, et les deux scripts d'installations de Dolibarr et MySQL sont lancé dans le Dockerfile à la création de l'image.

Nous utilisons un docker-compose pour build et lancer l'image Docker. Une fois le conteneur build et lancé nous pouvons nous rendre sur la page web et configurer Dolibarr.

Mais une fois la configuration terminée, une message d'erreur survient, nous prévenant que la base de donnée n'est pas joignable.
[insérer screenshot]

Après mintes tentatives de corrections de l'erreur, il ne nous était pas possible de passer outre cette erreur.
Nous avons donc pris la décision d'abandonner cette approche, pour partir de l'image Docker Dolibarr officielle pour continuer le projet.

---


#### Étapes > Plan B

Notre nouvelle approche pour continuer le projet est de recommencer en utilisant l'image Docker fourni par Dolibarr.
Dolibarr fourni dans sa documentation un docker-compose créant deux conteneurs, le service web Dolibarr ainsi que sa base de donnée.

Une fois le docker-compose lancé, nous avons accès à l'interface web Dolibarr, préconfiguré avec les variables renseignés dans le docker-compose.

Dolibarr étant fonctionnel nous pouvons commencer la création des scripts utilitaires de sauvegarde/restauration et d'import de données depuis un fichier CSV.

---


#### Étapes > Script de sauvegarde
Le script de sauvegarde `dump_database.sh` nous permet de faire un dump complet de la base de donnée Dolibarr au format texte (.sql) ou compressé (.bz2).
Le script est configurables à l'aide de variables pour définir, le user, password, database, compression du fichier, etc.
La sauvegarde est faite dans le dossier `database_backups` et contient la date de sauvegarde dans le nom. ex: `dump_database_20241204_1626.sql`

**Fonctionnement :** Le script est à lancer depuis la machine hôte et se connectera au conteneur Dolibarr web pour lancer la commande de dump sur la base de donnée. La commande sauvegarde le dump dans le dossier `/backups` du conteneur, ce dossier est un volume partagé sur l'hôte (database_backups).
Le fichier dump étant créé par l'utilisateur `root` du conteneur, il est nécessaire de changer l'appartenance du fichier pour être modifiable et supprimable sur la machine hôte. Le script fait donc ensuite un `chown` sur les sauvegardes avec l'ID et GID de l'utilisateur de la machine hôte.

---


#### Étapes > Script de restauration

TODO

**Fonctionnement :** TODO

---


#### Étapes > Script d'import de données

TODO

**Fonctionnement :** TODO



---


### Choix techniques et Difficultés

#### Méthode de déploiement

Nous avons explorés plusieurs méthodes de déploiements de Dolibarr afin d'évaluer la meilleure.
Les méthodes était :
- Dolideb : Paquet debian Dolibarr censé fonctionner après installation, ce n'était pas le cas.
- Image Docker officielle : Fourni avec un docker-compose, Dolibarr fonctionne parfaitement au premier lancement.
- Création d'une image Docker : Approche la plus complexe mais qui permet d'apprendre beaucoup plus de choses. C'est l'approche avec laquelle nous sommes parti. 


##### Dockerfile

Au départ nous sommes parti sur la création d'une image Docker custom avec notre installation de Dolibarr, ce qui n'a pas fonctionné car Dolibarr n'arrivais pas à joindre la DB, malgrès que nous pouvions la joindre depuis le conteneur Dolibarr web.

Nous avons essayé beaucoup de pistes sans succès :
- Laisser l'installateur Dolibarr créer l'utilisateur et la DB
- Créer la DB et l'utilisateur au préalable
- Créer la DB avec le compte root ou utilisateur
- Autoriser les connections à MySQL avec le compte utilisater depuis toute @ IP
- Exposer le port MySQL du conteneur
- Pistes sur le forum Dolibarr
- ...

Nous avons donc abandonné cette approche pour partir sur une image Dolibarr officielle.

---

#### Scripts de sauvegarde, restauration et import de données

Nous avons construits nos scripts de manière à être executés en dehors du conteneur pour plus de simplicité. Les scripts permettent d'exécuter des commandes à l'intérieurs des conteneurs à l'aide de `docker exec`.


---

#### Choix technique X



---

#### Choix technique X



---

#### Choix technique X



---


### Générations de données de tests

TODO
- Comment générer des données virtuelles: quelle IA génératives 
pouvez-vous utiliser? Quel "prompt" avez-vous donné? quel résultat? 
quelles limitations? Quelle pertinence?
Et rédiger un CR la-dessus.