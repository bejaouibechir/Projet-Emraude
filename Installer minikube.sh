#!/bin/bash

# Mettre à jour les paquets
echo "Mise à jour des paquets..."
sudo apt-get update -y

# Installer les dépendances requises pour Minikube
echo "Installation des dépendances requises..."
sudo apt-get install -y curl apt-transport-https virtualbox virtualbox-ext-pack

# Télécharger et installer kubectl
echo "Installation de kubectl..."
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
kubectl version --client

# Télécharger et installer Minikube
echo "Installation de Minikube..."
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube

# Démarrer Minikube
echo "Démarrage de Minikube..."
minikube start --driver=virtualbox

# Configurer kubectl pour utiliser Minikube
echo "Configuration de kubectl pour utiliser Minikube..."
kubectl config use-context minikube

# Activer l'Ingress dans Minikube
echo "Activation de l'Ingress..."
minikube addons enable ingress

# Activer Kubernetes Dashboard
echo "Activation du Kubernetes Dashboard..."
minikube addons enable dashboard

# Afficher l'URL du dashboard pour tester
echo "Ouverture du Dashboard Kubernetes..."
minikube dashboard --url
