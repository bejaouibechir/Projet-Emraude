### CED-III

Les techniques d'accès aux données couvrent plusieurs approches importantes à considérer dans le développement de microservices et d'applications distribuées :

1. **Base de données par service vs base de données partagées** : Cette décision implique de choisir entre **attribuer une base de données dédiée à chaque microservice** ou **partager une seule base de données entre plusieurs services**. Chaque option a ses avantages : la base de données par service offre plus d'**indépendance et de sécurité** pour chaque service, tandis qu'une base partagée peut faciliter la **consistance des données** mais au prix d'une **forte dépendance** entre les services.

2. **L’utilisation des ORMs vs créer sa propre couche d’accès aux données** : Les ORMs comme **Entity Framework** facilitent l'accès aux données en **générant automatiquement du code** pour interagir avec la base de données, tandis que **créer une couche manuelle** offre plus de **contrôle** et peut être **plus performant** dans certains cas. Toutefois, la maintenance et la complexité augmentent avec cette approche personnalisée.

3. **Utilisation d'Entity Framework (EF)** : EF est un ORM populaire dans l'écosystème .NET qui permet de **mapper les objets du code** à des tables de base de données. Il simplifie considérablement les opérations CRUD (Create, Read, Update, Delete) et aide à gérer les **migrations** de base de données.

4. **Exploration des méthodes de chargement EF : Eager, Lazy, Explicit** : EF propose trois façons de **charger les données liées**. Le chargement **eager** récupère toutes les données liées en une seule requête, le **lazy loading** les charge à la demande, et le **explicit loading** offre un **contrôle total** sur les requêtes supplémentaires à exécuter.

5. **Utilisation d'Entity Framework pour travailler avec des requêtes SQL brutes, des vues et des procédures stockées** : EF permet également de **bypasser certaines de ses abstractions** pour exécuter des **requêtes SQL** directement, ou travailler avec des **vues** et **procédures stockées** déjà existantes dans la base de données, offrant un compromis entre **flexibilité** et **simplicité**.

6. **Le SQL vs NoSQL pour le cas des microservices (exemple du Redis cache)** : Dans le contexte des microservices, il est souvent utile d'explorer l'usage du **NoSQL**, comme **Redis**, pour la gestion des caches ou des données temporaires. Le **SQL** est idéal pour les **transactions complexes** et les données fortement structurées, tandis que **NoSQL** brille dans les scénarios nécessitant une **grande scalabilité** et des **temps de réponse rapides**.

Ces six points permettent de mieux comprendre les choix techniques disponibles et leurs implications en matière de performance, d’évolutivité et de maintenabilité dans les architectures modernes.
