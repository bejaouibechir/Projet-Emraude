# Etapes post installation 

Une fois Kubernetes activé dans Docker Desktop, vous pouvez configurer le **Kubernetes Dashboard** et l'**Ingress Controller** en suivant les étapes ci-dessous.

### 1. **Activer le Kubernetes Dashboard**

Kubernetes Dashboard est une interface utilisateur web qui permet de gérer vos clusters Kubernetes. Pour l'activer, suivez ces étapes :

#### Étape 1 : Déployer le Dashboard
Exécutez la commande suivante pour installer le Dashboard via `kubectl` :

```bash
kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.7.0/aio/deploy/recommended.yaml
```

Cela va déployer le Kubernetes Dashboard et ses composants nécessaires dans le namespace `kubernetes-dashboard`.

#### Étape 2 : Créer un compte utilisateur pour accéder au Dashboard
Pour accéder au Dashboard, vous devez créer un compte utilisateur avec les autorisations nécessaires.

Créez un fichier YAML nommé `admin-user.yaml` contenant la configuration suivante :

```yaml
apiVersion: v1
kind: ServiceAccount
metadata:
  name: admin-user
  namespace: kubernetes-dashboard
---
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: admin-user
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: cluster-admin
subjects:
- kind: ServiceAccount
  name: admin-user
  namespace: kubernetes-dashboard
```

Appliquez ce fichier :

```bash
kubectl apply -f admin-user.yaml
```

#### Étape 3 : Obtenir le token d'accès
Une fois le compte utilisateur créé, obtenez un jeton d'accès avec la commande suivante :

```bash
kubectl -n kubernetes-dashboard create token admin-user
```

#### Étape 4 : Accéder au Kubernetes Dashboard
Pour accéder au Dashboard localement, vous devez exposer le service via un proxy. Exécutez cette commande pour lancer le proxy :

```bash
kubectl proxy
```

Le Kubernetes Dashboard sera disponible à l'adresse suivante :

```
http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/
```

Utilisez le token généré à l'étape précédente pour vous authentifier.

### 2. **Configurer l'Ingress Controller**

L'Ingress Controller permet d'exposer des services Kubernetes à l'extérieur du cluster en utilisant des ressources Ingress.

#### Étape 1 : Installer l'Ingress NGINX Controller
Pour installer le NGINX Ingress Controller, exécutez les commandes suivantes :

```bash
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/cloud/deploy.yaml
```

Cela déploiera l'Ingress NGINX Controller dans le namespace `ingress-nginx`.

#### Étape 2 : Vérifier le déploiement de l'Ingress Controller
Vérifiez que le contrôleur NGINX est bien déployé et en cours d'exécution :

```bash
kubectl get pods -n ingress-nginx
```

Vous devriez voir des pods `ingress-nginx-controller` en cours d'exécution.

#### Étape 3 : Créer une ressource Ingress
Une fois le contrôleur déployé, vous pouvez créer des ressources Ingress pour exposer vos services. Voici un exemple simple de fichier YAML pour un service Ingress :

```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: example-ingress
  namespace: default
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /
spec:
  rules:
  - host: example.local
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: example-service
            port:
              number: 80
```

Appliquez ce fichier :

```bash
kubectl apply -f ingress-example.yaml
```
```bash
kubectl get svc -n ingress-nginx
```

---
