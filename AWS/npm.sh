#!/bin/bash

# Update package list
sudo yum update -y
sudo yum install git -y

# install kubectl

sudo curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.23.6/bin/linux/amd64/kubectl
sudo chmod +x ./kubectl
sudo mkdir -p $HOME/bin && sudo cp ./kubectl $HOME/bin/kubectl && export PATH=$PATH:$HOME/bin

# helm installation
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
