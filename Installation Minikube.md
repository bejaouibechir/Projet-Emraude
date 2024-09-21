## Installation de Minikube

### Installation Minikube sur Linux :
1. **Installer Docker**.
2. Exécuter les commandes suivantes :
    ```bash
    curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
    sudo install minikube-linux-amd64 /usr/local/bin/minikube
    sudo usermod -aG docker $USER && newgrp docker
    sudo minikube start --driver=docker
    ```
3. **Vérification de l'installation** :
    ```bash
    minikube version
    ```

4. **Installer Kubectl** :
    ```bash
    curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl
    chmod +x kubectl
    sudo mv kubectl /usr/local/bin/
    ```

---
