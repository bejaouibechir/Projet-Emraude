#!/bin/bash

# Note: Pour créer une application qui utilise des controllers il faut appliquer cette commande dotnet new webapi -n MyNetApp --use-controllers

# Mettre à jour les paquets
echo "Mise à jour des paquets..."
sudo apt-get update -y

# Installer apt-transport-https pour autoriser les dépôts via HTTPS
echo "Installation des dépendances requises..."
sudo apt-get install -y apt-transport-https

# Télécharger la clé et le dépôt Microsoft
echo "Ajout de la clé Microsoft et du dépôt..."
wget https://packages.microsoft.com/config/ubuntu/$(lsb_release -rs)/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb

# Mettre à jour les paquets après l'ajout du dépôt Microsoft
echo "Mise à jour des paquets après ajout du dépôt..."
sudo apt-get update -y

# Installer le SDK .NET 8
echo "Installation du SDK .NET 8..."
sudo apt-get install -y dotnet-sdk-8.0

# Vérification de l'installation
echo "Vérification de l'installation de .NET..."
dotnet --version

echo "Installation terminée avec succès."
