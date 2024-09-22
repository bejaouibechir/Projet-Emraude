# Gérer Minikube

Pour lancer **Minikube**, suivez les étapes ci-dessous après avoir installé Minikube et ses dépendances sur votre machine :

### 1. **Lancer Minikube avec un pilote spécifique**
Minikube utilise un **driver** (pilote) pour démarrer les machines virtuelles. Vous pouvez utiliser **VirtualBox**, **Docker**, ou d'autres pilotes supportés. Voici comment le démarrer avec **VirtualBox** ou **Docker** :

#### Avec VirtualBox (si VirtualBox est installé) :

```bash
minikube start --driver=virtualbox
```

#### Avec Docker (si Docker est installé) :

```bash
minikube start --driver=docker
```

Minikube commencera à télécharger et configurer un cluster Kubernetes à l'aide du pilote choisi.

### 2. **Vérifier le statut de Minikube**

Après avoir démarré Minikube, vous pouvez vérifier son statut avec :

```bash
minikube status
```

Cela vous donnera des informations sur l'état du cluster, du kubelet et de l'API server.

### 3. **Configurer kubectl pour utiliser Minikube**

Minikube configure automatiquement **kubectl** pour pointer vers son cluster. Pour vous en assurer, utilisez cette commande :

```bash
kubectl config use-context minikube
```

Vous pouvez maintenant utiliser **kubectl** pour interagir avec votre cluster Minikube.

### 4. **Vérifier les nœuds dans Kubernetes**

Pour vérifier si le cluster Minikube fonctionne correctement, listez les nœuds disponibles :

```bash
kubectl get nodes
```

Le nœud Minikube devrait apparaître avec un statut **Ready**.

### 5. **Accéder à Kubernetes Dashboard**

Si vous avez activé le Kubernetes Dashboard avec Minikube, vous pouvez l'ouvrir avec :

```bash
minikube dashboard
```

Cela ouvrira le Kubernetes Dashboard dans votre navigateur, où vous pourrez visualiser et gérer votre cluster.

### 6. **Arrêter Minikube**

Si vous souhaitez arrêter Minikube, exécutez :

```bash
minikube stop
```

### 7. **Supprimer le cluster Minikube (optionnel)**

Si vous voulez supprimer complètement le cluster :

```bash
minikube delete
```

### Exemple Complet

Voici un exemple pour démarrer Minikube avec Docker :

```bash
minikube start --driver=docker
kubectl get nodes
minikube dashboard
```

Cela lancera le cluster Kubernetes avec Minikube en utilisant Docker, vérifiera les nœuds, et ouvrira le Dashboard.
