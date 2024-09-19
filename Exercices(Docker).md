# Exercices Docker

### Exercice 1: Conteneurisation d'une application **.NET 8.0 Web API** avec MongoDB

#### Objectif :
- Conteneuriser une API **.NET Core 8.0 Web API**.
- Configurer **MongoDB** comme base de données.

#### Étapes :

1. **Créer une API .NET 8.0** :
   ```bash
   dotnet new webapi -o C:\temp\MongoApi
   ```
2. **Ajouter les dépendances MongoDB** :
   ```bash
   dotnet add package MongoDB.Driver
   ```
3. **Configurer l'application pour utiliser MongoDB** :
    - Ajouter un modèle de données, un contrôleur, et configurer `appsettings.json` pour que MongoDB se connecte à **localhost**.
4. **Créer le fichier `Dockerfile`** pour conteneuriser l'application.
5. **Créer un fichier `docker-compose.yml`** qui inclut MongoDB.
6. **Tester l'API en utilisant MongoDB conteneurisé**.

#### Solution :

##### Dockerfile :
```Dockerfile
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app
COPY . .
RUN dotnet restore
RUN dotnet build -c Release -o /app/build
RUN dotnet publish -c Release -o /app/publish

FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
WORKDIR /app
COPY --from=build /app/publish .
EXPOSE 8080
ENTRYPOINT ["dotnet", "MongoApi.dll"]
```

##### docker-compose.yml :
```yaml
version: '3.8'

services:
  api:
    build: .
    ports:
      - "8080:8080"
    depends_on:
      - mongo

  mongo:
    image: mongo
    ports:
      - "27017:27017"
    volumes:
      - mongo-data:/data/db

volumes:
  mongo-data:
```

- **Accéder à l'API** : `http://localhost:8080`
- **MongoDB** sera accessible sur `mongodb://localhost:27017`.

---

### Exercice 2: Conteneurisation d'une application **.NET 8.0 MVC** avec MySQL

#### Objectif :
- Conteneuriser une application **.NET Core 8.0 MVC**.
- Configurer **MySQL** comme base de données.

#### Étapes :

1. **Créer une application MVC .NET 8.0** :
   ```bash
   dotnet new mvc -o C:\temp\MVCApp
   ```
2. **Ajouter les dépendances MySQL** :
   ```bash
   dotnet add package MySql.EntityFrameworkCore
   ```
3. **Configurer `appsettings.json` pour se connecter à MySQL** :
   ```json
   {
     "ConnectionStrings": {
       "DefaultConnection": "Server=localhost;Database=mvcappdb;User=myuser;Password=mypassword;"
     }
   }
   ```
4. **Créer un Dockerfile** pour conteneuriser l'application.
5. **Créer un fichier `docker-compose.yml`** pour orchestrer MySQL et l'application.
6. **Lancer les conteneurs et tester l'application MVC.**

#### Solution :

##### Dockerfile :
```Dockerfile
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app
COPY . .
RUN dotnet restore
RUN dotnet build -c Release -o /app/build
RUN dotnet publish -c Release -o /app/publish

FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
WORKDIR /app
COPY --from=build /app/publish .
EXPOSE 8080
ENTRYPOINT ["dotnet", "MVCApp.dll"]
```

##### docker-compose.yml :
```yaml
version: '3.8'

services:
  app:
    build: .
    ports:
      - "8080:8080"
    depends_on:
      - mysql

  mysql:
    image: mysql:latest
    environment:
      MYSQL_ROOT_PASSWORD: 'mypassword'
      MYSQL_DATABASE: 'mvcappdb'
    ports:
      - "3306:3306"
    volumes:
      - mysql-data:/var/lib/mysql

volumes:
  mysql-data:
```

- **Accéder à l'application MVC** : `http://localhost:8080`
- **MySQL** sera accessible sur `localhost:3306`.

---

### Exercice 3: Conteneurisation d'une application **.NET 8.0 Web API** avec Redis pour la gestion de cache

#### Objectif :
- Conteneuriser une API **.NET Core 8.0 Web API**.
- Configurer **Redis** comme cache distribué.

#### Étapes :

1. **Créer une API .NET 8.0** :
   ```bash
   dotnet new webapi -o C:\temp\RedisApi
   ```
2. **Ajouter la dépendance Redis** :
   ```bash
   dotnet add package Microsoft.Extensions.Caching.StackExchangeRedis
   ```
3. **Configurer `appsettings.json` pour se connecter à Redis** :
   ```json
   {
     "Redis": {
       "ConnectionString": "localhost:6379"
     }
   }
   ```
4. **Créer un Dockerfile pour l'application**.
5. **Créer un fichier `docker-compose.yml`** qui inclut Redis.
6. **Tester l'API en utilisant Redis comme cache conteneurisé**.

#### Solution :

##### Dockerfile :
```Dockerfile
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app
COPY . .
RUN dotnet restore
RUN dotnet build -c Release -o /app/build
RUN dotnet publish -c Release -o /app/publish

FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
WORKDIR /app
COPY --from=build /app/publish .
EXPOSE 8080
ENTRYPOINT ["dotnet", "RedisApi.dll"]
```

##### docker-compose.yml :
```yaml
version: '3.8'

services:
  api:
    build: .
    ports:
      - "8080:8080"
    depends_on:
      - redis

  redis:
    image: redis
    ports:
      - "6379:6379"
```

- **Accéder à l'API** : `http://localhost:8080`
- **Redis** sera accessible sur `localhost:6379`.

---

### Exercice 4: Déploiement d'une application **.NET 8.0 Web MVC** avec Nginx comme serveur proxy

#### Objectif :
- Conteneuriser une application **.NET Core 8.0 MVC**.
- Configurer **Nginx** comme serveur proxy inverse.

#### Étapes :

1. **Créer une application MVC .NET 8.0** :
   ```bash
   dotnet new mvc -o C:\temp\NginxMVC
   ```
2. **Configurer une application MVC standard**.
3. **Créer un Dockerfile pour l'application MVC**.
4. **Créer un Dockerfile pour Nginx**.
5. **Créer un fichier `docker-compose.yml`** pour orchestrer les deux conteneurs.
6. **Tester l'application MVC en utilisant Nginx comme proxy**.

#### Solution :

##### Dockerfile pour l'application :
```Dockerfile
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app
COPY . .
RUN dotnet restore
RUN dotnet build -c Release -o /app/build
RUN dotnet publish -c Release -o /app/publish

FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
WORKDIR /app
COPY --from=build /app/publish .
EXPOSE 8080
ENTRYPOINT ["dotnet", "NginxMVC.dll"]
```

##### Dockerfile pour Nginx :
```Dockerfile
FROM nginx:alpine
COPY ./nginx.conf /etc/nginx/nginx.conf
```

##### nginx.conf :
```nginx
server {
    listen 80;
    location / {
        proxy_pass http://localhost:8080;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}
```

##### docker-compose.yml :
```yaml
version: '3.8'

services:
  web:
    build: .
    ports:
      - "8080:8080"

  nginx:
    build:
      context: .
      dockerfile: Nginx.Dockerfile
    ports:
      - "80:80"
    depends_on:
      - web
```

- **Accéder à l'application MVC** : `http://localhost`
- **L'application Web est exposée sur le port 8080**.

---

### Exercice 5: Conteneurisation d'une application **.NET 8.0 Web API** avec Elasticsearch et Kibana pour la gestion des logs

#### Objectif :
- Conteneuriser une application **.NET Core 8.0 Web API**.
- Utiliser **Elasticsearch** pour stock

er les logs et **Kibana** pour les visualiser.

#### Étapes :

1. **Créer une API .NET 8.0** :
   ```bash
   dotnet new webapi -o C:\temp\LogApi
   ```
2. **Ajouter les dépendances pour Elasticsearch** :
   ```bash
   dotnet add package Serilog.Sinks.Elasticsearch
   dotnet add package Serilog.AspNetCore
   ```
3. **Configurer `appsettings.json` pour se connecter à Elasticsearch** :
   ```json
   {
     "Elasticsearch": {
       "Uri": "http://localhost:9200"
     }
   }
   ```
4. **Créer un Dockerfile pour l'application**.
5. **Créer un fichier `docker-compose.yml`** avec Elasticsearch et Kibana.
6. **Tester l'API et utiliser Kibana pour visualiser les logs.**

#### Solution :

##### Dockerfile :
```Dockerfile
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app
COPY . .
RUN dotnet restore
RUN dotnet build -c Release -o /app/build
RUN dotnet publish -c Release -o /app/publish

FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
WORKDIR /app
COPY --from=build /app/publish .
EXPOSE 8080
ENTRYPOINT ["dotnet", "LogApi.dll"]
```

##### docker-compose.yml :
```yaml
version: '3.8'

services:
  api:
    build: .
    ports:
      - "8080:8080"
    depends_on:
      - elasticsearch
      - kibana

  elasticsearch:
    image: docker.elastic.co/elasticsearch/elasticsearch:8.5.0
    environment:
      - discovery.type=single-node
    ports:
      - "9200:9200"

  kibana:
    image: docker.elastic.co/kibana/kibana:8.5.0
    ports:
      - "5601:5601"
    depends_on:
      - elasticsearch
```

#### Étapes pour utiliser Kibana :
1. **Lancer Kibana et Elasticsearch** avec Docker Compose :
   ```bash
   docker-compose up --build
   ```
2. **Accéder à Kibana** : `http://localhost:5601`.
3. **Configurer Kibana pour visualiser les logs** :
   - Dans Kibana, allez dans **"Stack Management"** > **"Index Patterns"** et créez un index pattern basé sur `logstash-*`.
   - Vous verrez les logs générés par l'API **.NET Core** dans **"Discover"**.

