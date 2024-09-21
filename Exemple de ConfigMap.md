# Cas de configuration de Config Map


### Contexte : Configuration d'un MySQL avec ConfigMap

Supposons que vous voulez configurer MySQL avec des paramètres spécifiques (comme la configuration des journaux ou la gestion des connexions) en utilisant un **fichier de configuration MySQL** et stocker cette configuration dans un **ConfigMap**.

Voici comment vous pouvez procéder.

#### 1. Exemple de fichier de configuration MySQL : `my-custom.cnf`

Disons que vous avez un fichier de configuration MySQL nommé `my-custom.cnf` qui contient des paramètres spécifiques pour MySQL :

```ini
[mysqld]
sql_mode=STRICT_TRANS_TABLES
max_connections=200
log_error=/var/log/mysql/error.log
```

Ce fichier définit quelques options comme le mode SQL, le nombre maximum de connexions, et l'emplacement du fichier de log d'erreurs.

### 2. Créer un ConfigMap à partir de ce fichier

Maintenant, vous voulez créer un **ConfigMap** qui stocke ce fichier `my-custom.cnf` pour l'utiliser dans votre déploiement MySQL.

Exécutez la commande suivante pour créer le ConfigMap :

```bash
kubectl create configmap mysql-config --from-file=my-custom.cnf
```

- **`mysql-config`** : C'est le nom du ConfigMap.
- **`--from-file=my-custom.cnf`** : Ce paramètre spécifie que le fichier de configuration `my-custom.cnf` doit être ajouté au ConfigMap.

### 3. Vérification du ConfigMap

Vous pouvez maintenant vérifier que le ConfigMap a été créé et qu'il contient les données du fichier `my-custom.cnf` :

```bash
kubectl get configmap mysql-config -o yaml
```

Cela devrait afficher quelque chose comme ceci :

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: mysql-config
data:
  my-custom.cnf: |
    [mysqld]
    sql_mode=STRICT_TRANS_TABLES
    max_connections=200
    log_error=/var/log/mysql/error.log
```

### 4. Utiliser le ConfigMap dans le Déploiement MySQL

Ensuite, vous devez **monter** ce fichier de configuration dans le pod MySQL. Voici un exemple de fichier YAML de déploiement MySQL où le ConfigMap est monté dans le conteneur :

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
          value: "rootpassword"
        volumeMounts:
        - name: mysql-config-volume
          mountPath: /etc/mysql/conf.d
          subPath: my-custom.cnf
      volumes:
      - name: mysql-config-volume
        configMap:
          name: mysql-config
```

- **volumeMounts** : Le fichier de configuration `my-custom.cnf` est monté dans le répertoire `/etc/mysql/conf.d` à l'intérieur du conteneur MySQL. MySQL lit automatiquement les fichiers `.cnf` présents dans ce répertoire.
- **volumes** : Le volume `mysql-config-volume` est lié au ConfigMap nommé `mysql-config`.

### 5. Redémarrer le déploiement pour appliquer la configuration

Après avoir mis à jour le fichier de déploiement avec ce volume, appliquez la modification pour redéployer MySQL avec la nouvelle configuration :

```bash
kubectl apply -f mysql-deployment.yaml
```

Kubernetes redéploiera votre pod MySQL avec le fichier de configuration personnalisé pris en compte.

### Conclusion

Dans cet exemple :
- Nous avons créé un **ConfigMap** à partir d'un fichier de configuration MySQL (`my-custom.cnf`).
- Ce **ConfigMap** a ensuite été monté dans un pod MySQL via un volume, de sorte que MySQL puisse utiliser ce fichier pour configurer son comportement.

Ce procédé est idéal pour gérer dynamiquement la configuration d'une application comme MySQL dans Kubernetes, sans avoir à reconstruire l'image Docker.
