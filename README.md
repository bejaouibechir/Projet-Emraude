### CED-III

La sécurisation des microservices est essentielle pour garantir la protection des données et des transactions. Voici les principaux aspects à considérer :

1. **Identification des types d'attaques (SQL injection, spoofing, etc.) et prévention** :

Il est crucial d'**identifier les attaques potentielles** comme l'**injection SQL**, le **spoofing**, et d'autres attaques courantes. La prévention inclut des mesures telles que l'**utilisation de requêtes paramétrées**, le **chiffrement des communications**, et des **politiques de validation stricte** des entrées utilisateur pour limiter les risques de compromission.

2. **Gestion des autorisations et des rôles avec JWT et/ou OAuth2** :

La gestion des autorisations dans les microservices repose souvent sur des **tokens JWT** ou sur des protocoles comme **OAuth2**. Cela permet d’**assigner des rôles** spécifiques aux utilisateurs et d’assurer que seuls ceux ayant les droits appropriés peuvent accéder aux ressources sensibles.

3. **Utilisation de JWT (JSON Web Tokens) pour l'authentification et l'autorisation entre microservices** :

Les **JWT** sont largement utilisés pour **authentifier et autoriser** les requêtes entre les microservices. Chaque requête est accompagnée d’un token qui contient les informations d’authentification, assurant ainsi une **sécurité renforcée** sans avoir à stocker d’état sur le serveur.

Ces trois points mettent en lumière l'importance de la **sécurité** dans un environnement microservices, avec des pratiques spécifiques pour **identifier, prévenir** les attaques et **gérer les accès** aux ressources critiques.
