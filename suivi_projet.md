# Journal de bord

* SAE Dolibarr
* SAHUC Maxime
* CAMBON Marc
* 5 novembre 2024


## Séance n° 1

* 05/11/2024 - 14h30/16h
* Etude du sujet et recherche d'information sur l'ERP/CRM
* A faire à la prochaine séance : Prise en main de Dolibarr


## Séance n° 2

* 06/11/2024 - 8h30/11h30
* Première prise en main de Dolibarr via le docker-compose de la documentation, et insertion de données de test.
* A faire à la prochaine séance : installation manuelle de Dolibarr dans une VM afin d'établir une liste des étapes nécessaires à l'installation.


## Séance n° 3

* 07/11/2024 - 8h30/19h
* Installation manuelle de Dolibarr dans un container docker ubuntu.
* Difficultés rencontrées : l'installation avec fichier deb ne semble pas fonctionnelle, le service n'est pas accessible.
* Remarques sur la séances : perdu pas mal de temps sur l'installation dans une VM vagrant qui avais des soucis de réseaux, nous sommes finalement passés sur un container docker.
* A faire à la prochaine séance : diviser le travail en 2 : l'un installe manuellement Dolibarr et note les étapes, l'autre commence à étudier l'import/export de donnés dans Dolibarr via requêtes SQL.


## Séance n° 4

* 12/11/2024 - 8h30/11h30
* Travail effectué : création d'une image docker LAMP et début de l'installation manuelle de Dolibarr dans ce container
* A faire à la prochaine séance : continuer l'installation manuelle de Dolibarr dans le container, et avancer sur les scripts d'import/exports de données.


## Séance n° 5

* 14/11/2024 - 13h/16h
* Travail effectué : Scripts d'installation de MySQL et Dolibarr avec un container ubuntu, l'installation fonctionne mais Dolibarr demande de configurer des choses manuellement. Script de dump de la base de donnée fait.
* A faire à la prochaine séance : Script pour restorer Dolibarr depuis un dump de la BDD. Tester d'importer un dump dans l'image Docker custom pour essayer de bypass la configuration manuelle demandée.
* Difficultés rencontrées : /


## Séance n° 6

* 04/12/2024 - 8h30/19h
* Travail effectué : Refacto du script de dump de la DB Dolibarr. Travail sur l'import de données CSV dans Dolibarr. Commencement du rapport technique et script de restauration de base de données.
* A faire à la prochaine séance : Rapport, script d'import CSV, script de restauration, crontab pour sauvegardes quotidiennes.
* Difficultés rencontrées : Notre première approche avec un Dockerfile custom ubuntu et des scripts d'installation de Dolibarr n'a pas été concluante. Nous avons donc pris la décision de partir sur l'image Docker fournie par Dolibarr afin d'avoir une version fonctionnelle.


Checklist avant rendu :
- dolibarr fonctionnel
- dolibarr préconfiguré dès le 1er lancement
- dump de DB
- restauration de la DB
- import via CSV
- crontab dump automatique

TODO :
- script dump DB : argument pour la compression

## Séance n° X

* date - heure
* Travail effectué
* A faire à la prochaine séance
* Difficultés rencontrées
* Remarques sur la séances (membre absent, pbe technique, ...)


...