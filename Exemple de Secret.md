# Exemple de fichier de déploiement :

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: mysql-deployment
spec:
  replicas: 1
  selector:
    matchLabels:
      app: mysql
  template:
    metadata:
      labels:
        app: mysql
    spec:
      containers:
      - name: mysql
        image: mysql:5.7
        env:
        - name: MYSQL_ROOT_PASSWORD
          valueFrom:
            secretKeyRef:
              name: mysql-secret   # Le Secret qui contient le mot de passe
              key: rootpassword    # La clé contenant le mot de passe dans le Secret
        ports:
        - containerPort: 3306
```

Dans ce fichier de déploiement :
- **`valueFrom.secretKeyRef`** permet de récupérer la valeur du Secret `mysql-secret` et de l'utiliser pour la variable d'environnement `MYSQL_ROOT_PASSWORD`.

### 3. **Appliquer le fichier de déploiement**

Appliquez le fichier de déploiement mis à jour avec la commande suivante :

```bash
kubectl apply -f mysql-deployment.yaml
```

Cela déploiera MySQL avec le mot de passe root récupéré du Secret.

### 4. **Vérifier le Secret dans le pod**

Vous pouvez vérifier si le Secret a bien été injecté en inspectant les variables d'environnement dans le pod MySQL :

```bash
kubectl exec -it <mysql-pod-name> -- env | grep MYSQL_ROOT_PASSWORD
```

Cela affichera la variable `MYSQL_ROOT_PASSWORD` utilisée dans le pod.

---

### Résumé des commandes pour les Secrets

1. **Créer un Secret** à partir d'une clé-valeur :
   ```bash
   kubectl create secret generic <secret-name> --from-literal=<key>=<value>
   ```

2. **Lister les Secrets** :
   ```bash
   kubectl get secrets
   ```

3. **Voir le contenu d'un Secret** encodé en base64 :
   ```bash
   kubectl get secret <secret-name> -o yaml
   ```

4. **Voir le contenu d'un Secret décodé** :
   ```bash
   kubectl get secret <secret-name> -o jsonpath="{.data.<key>}" | base64 --decode
   ```

5. **Supprimer un Secret** :
   ```bash
   kubectl delete secret <secret-name>
   ```

6. **Référencer un Secret dans un déploiement** (comme dans le déploiement MySQL pour stocker `rootpassword`).

---

Avec ce processus, vous pouvez sécuriser les informations sensibles comme les mots de passe et les utiliser de manière sûre dans votre cluster Kubernetes.
