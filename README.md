### CED-III

La **communication entre microservices** est cruciale pour assurer une coordination efficace entre les services dans une architecture distribuée. Voici les principales techniques de communication :

1. **Les services Mesh** : Un **Service Mesh** est une infrastructure dédiée qui gère la **communication inter-microservices**. Il simplifie la gestion des **communications réseau**, comme le **routage**, la **sécurité** (chiffrement des communications), et le **monitoring** sans ajouter de complexité aux services eux-mêmes. Exemples : **Istio** et **Linkerd**.

2. **Communication interservice (gRPC)** : **gRPC** est un framework RPC (Remote Procedure Call) performant qui utilise **HTTP/2** pour des communications interservices rapides et **bénéficie du support du streaming**. Il est souvent utilisé lorsque les **performances et l'efficacité réseau** sont prioritaires.

3. **Communication interservice (Kafka)** : **Apache Kafka** est une plateforme de streaming distribué utilisée pour la **messagerie asynchrone**. Il est idéal pour gérer des flux de données **en temps réel** et des cas où les microservices doivent **traiter de grandes quantités de données** ou s'intégrer à des systèmes de logs.

4. **Communication interservice (RabbitMQ)** : **RabbitMQ** est un message broker qui facilite la **communication asynchrone** entre microservices via un système de **files d'attente**. Il assure la **fiabilité** des messages envoyés et reçus même en cas de panne temporaire d’un service.

5. **Création du service GraphQL et OData** : **GraphQL** et **OData** sont des technologies permettant de **requêter des API de manière flexible**. GraphQL permet aux clients de **demander précisément les données** dont ils ont besoin, tandis qu’OData offre un **protocole REST enrichi** avec des fonctionnalités de requêtes avancées. Les deux approches facilitent les **requêtes dynamiques** et les **interactions riches** avec les microservices.

Ces cinq points illustrent les différentes approches pour **connecter les microservices** de manière **synchrone** ou **asynchrone**, en fonction des besoins de performance, de robustesse et de scalabilité du système.
