### CED-III

L'**introduction aux microservices et à leur architecture** englobe plusieurs concepts fondamentaux et des techniques clés pour une conception efficace d'une architecture distribuée. Voici les points à retenir :

1. **Concepts clés : découpage, indépendance, communication** :

Les **microservices** se caractérisent par leur **découpage** en services autonomes, leur **indépendance** en termes de déploiement et d'évolution, et leur capacité à **communiquer** entre eux via des protocoles comme HTTP, gRPC, ou des solutions de messagerie.

3. **Principes de conception d'architecture de microservices** :

L'architecture microservices repose sur des principes de **modularité**, de **faible couplage** et de **forte cohésion**, où chaque service gère une **fonctionnalité métier spécifique** et peut être déployé indépendamment.

5. **Comparaison avec les architectures monolithiques et techniques de migration** :
   
La migration d'une architecture **monolithique** vers des microservices est nécessaire lorsqu'il y a des besoins en **scalabilité**, **rapidité de développement** et **agilité**. Toutefois, elle peut être **désavantageuse** dans des environnements où la complexité supplémentaire ou la **surcharge de gestion** n'est pas justifiée.

7. **Présentation sur le déploiement des applications microservices avec Docker et Kubernetes** :

**Docker** et **Kubernetes** sont les outils clés pour le **déploiement et la gestion** des microservices. Docker assure l'**isolation** des services dans des conteneurs, tandis que Kubernetes orchestre ces conteneurs dans des environnements distribués. Une formation dédiée à ces outils est souvent recommandée pour les maîtriser de manière approfondie.

9. **Techniques de communications inter microservices avec gRPC et Mesh** :
    
**gRPC** et les **Service Mesh** (comme Istio) sont des solutions efficaces pour **connecter les microservices**. gRPC permet des communications rapides et optimisées, tandis qu'un service mesh ajoute des fonctionnalités avancées de **gestion des communications**, telles que le routage et la résilience.

11. **Intégration de Kafka comme middleware de communication entre microservices** :

**Kafka** joue le rôle de **middleware** pour la communication **asynchrone** entre microservices, agissant comme un **Service Broker** qui assure la gestion des flux de données massifs en temps réel.

13. **Intégration de RabbitMQ comme middleware de communication asynchrone entre microservices** :
    
**RabbitMQ** est un **message broker** qui facilite la communication asynchrone entre microservices, particulièrement utile pour les **systèmes distribués** qui doivent gérer des échanges de messages fiables.

15. **Exploration de GraphQL & OData pour des requêtes flexibles sur les microservices** :

**GraphQL** et **OData** offrent des moyens flexibles de **requêter des API** en microservices. Ils permettent aux clients de **personnaliser leurs requêtes** en fonction des données exactes dont ils ont besoin, simplifiant ainsi les interactions complexes.

17. **Communication en temps réel avec SignalR** :
    
**SignalR** permet de gérer des **communications en temps réel** entre les microservices et les clients, idéale pour des scénarios comme les **notifications instantanées** ou les **mises à jour en direct**.

Ces points forment une base solide pour comprendre l'architecture des microservices et leurs mécanismes de **communication** et de **déploiement**, tout en offrant une vision sur les **techniques modernes** de gestion des interactions dans un système distribué.
