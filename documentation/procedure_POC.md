# Procédure POC

1) Lancer la première installation et vérifier que l'instance Dolibarr vierge est bien fonctionnelle: [première installation](./documentation/procedure_premiere_install.md)
2) Importer le dump SQL fourni "dump_first_install.sql" et vérifier la présence des données:  [Restauration](./documentation/procedure_sauvegarde_restauration.md)
3) Importer le fichier CSV fourni "test_users.csv" et vérifier la présence des données dans Dolibarr:  [import CSV](./documentation/import_donnee_csv.md)
4) Réaliser une sauvegarde des données et supprimer les containers:   [Sauvegarde](./documentation/procedure_sauvegarde_restauration.md) & [Suppression](./documentation/procedure_premiere_install.md)
5) Réimporter le dump réalisé précédemment et vérifié la persistance des données:   [Restauration](./documentation/procedure_sauvegarde_restauration.md)