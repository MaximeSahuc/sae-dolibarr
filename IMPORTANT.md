## Important

### Cahier des charges

- Les script sont découpés en plusieurs scripts
- Script d'Installation : install.sh => install Dolibarr + SGBD
- Script d'Import des données : import_csv.sh => importer **toute** les données
- Script de Sauvegarde des données : sauvegarde **toute** les données pour les réstaurer plus tard
- Dockerisé : Créer un Dockerfile => scripts de lancements et importation de BDD ; BDD dans un conteneur séparé


# Modalités pratiques

- Définir le chef de projet
- repo git : sae-dolibarr
- avoir à la racine du repo : readme.md ; sources.md ; suivi_projet.md
- template doc suivi de projet : https://github.com/skramm/but3_rt/blob/main/suivi_projet.md
- Pour les fonctionnalités à mettre en place dans Dolibarr, on se limitera à une gestion des ”Tiers” : une liste de clients/fournisseurs.

Arbo repo _exemple_:
sae-dolibarr
|-- docs/
|-- sources/
|-- tests/
|-- data/
|-- sources.md
|-- readme.md
|-- suivi_projet.md
|-- ...
