# Exemple de persistence PV/PVC

Voici une démo complète qui guide à travers les étapes pour créer un déploiement MySQL avec persistance de données en Kubernetes.

### Étape 1 : Créer un déploiement MySQL avec 4 réplicas

#### 1.1. Déploiement MySQL sans persistance
On commence par créer un déploiement avec 4 réplicas sans persistance.

Créez un fichier YAML pour le déploiement :

```yaml
# mysql-deployment.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: mysql-deployment
spec:
  replicas: 4
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
          value: "rootpassword"
        ports:
        - containerPort: 3306
```

Appliquez-le avec la commande :

```bash
kubectl apply -f mysql-deployment.yaml
```

### Étape 2 : Exposer via un service

Exposons le déploiement via un service pour permettre l'accès à MySQL.

Créez un service YAML :

```yaml
# mysql-service.yaml
apiVersion: v1
kind: Service
metadata:
  name: mysql-service
spec:
  selector:
    app: mysql
  ports:
    - protocol: TCP
      port: 3306
      targetPort: 3306
  type: NodePort
```

Appliquez-le :

```bash
kubectl apply -f mysql-service.yaml
```

Pour vérifier le port exposé par `NodePort`, utilisez :

```bash
kubectl get service mysql-service
```

L'output ressemblera à :

```bash
NAME            TYPE       CLUSTER-IP       EXTERNAL-IP   PORT(S)          AGE
mysql-service   NodePort   10.103.139.216   <none>        3306:32000/TCP   2m
```

Le port exposé sera dans la plage 30000-32767. Accédez à MySQL via **MySQL Workbench** sur `localhost:<port>` (dans cet exemple, ce serait `localhost:32000`).

### Étape 3 : Tester via MySQL Workbench (Données perdues après redémarrage)

1. **Ouvrez MySQL Workbench** et connectez-vous à MySQL avec `localhost:32000`, root, et le mot de passe `rootpassword`.
2. Créez une base de données et une table avec des données test.
3. Redémarrez les pods (supprimez les pods pour voir la perte de données) :

   ```bash
   kubectl delete pod -l app=mysql
   ```

4. Une fois les pods recréés, reconnectez-vous à MySQL Workbench, et vous verrez que les données **ne sont plus présentes**, car MySQL ne conserve pas les données sans un volume persistant.

### Étape 4 : Créer PV/PVC et les attacher au déploiement

#### 4.1. Créer un PersistentVolume (PV) et un PersistentVolumeClaim (PVC)

Créez le fichier suivant pour le **PV** et le **PVC** :

```yaml
# mysql-pv-pvc.yaml
apiVersion: v1
kind: PersistentVolume
metadata:
  name: mysql-pv
spec:
  capacity:
    storage: 1Gi
  accessModes:
    - ReadWriteOnce
  hostPath:
    path: "/mnt/data/mysql"
---
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: mysql-pvc
spec:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 1Gi
```

Appliquez ce fichier :

```bash
kubectl apply -f mysql-pv-pvc.yaml
```

#### 4.2. Modifier le déploiement MySQL pour utiliser le PVC

Modifiez le fichier du déploiement MySQL pour attacher le volume persistant :

```yaml
# mysql-deployment-with-pvc.yaml
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
          value: "rootpassword"
        ports:
        - containerPort: 3306
        volumeMounts:
        - name: mysql-storage
          mountPath: /var/lib/mysql
      volumes:
      - name: mysql-storage
        persistentVolumeClaim:
          claimName: mysql-pvc
```

Appliquez cette modification :

```bash
kubectl apply -f mysql-deployment-with-pvc.yaml
```

### Étape 5 : Tester via MySQL Workbench (Données persistantes après redémarrage)

1. **Connectez-vous à MySQL Workbench** via `localhost:32000` et recréez la base de données et la table.
2. Redémarrez les pods en supprimant à nouveau les pods MySQL :

   ```bash
   kubectl delete pod -l app=mysql
   ```

3. Après le redémarrage, reconnectez-vous à MySQL Workbench. Cette fois, vous constaterez que les **données sont toujours présentes**, car le volume persistant (PV/PVC) stocke les données en dehors du cycle de vie des pods.

---

Cette démo montre clairement comment l'absence de volumes persistants entraîne une perte de données et comment attacher des volumes avec PV/PVC garantit la persistance des données.
