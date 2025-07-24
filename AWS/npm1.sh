#!/bin/bash


# Update package list
sudo yum update -y
sudo yum install git -y


# ------------------------
# Install Docker
# ------------------------
sudo yum install -y docker
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -aG docker ec2-user

# Install Docker Compose
sudo curl -L "https://github.com/docker/compose/releases/download/v2.24.7/docker-compose-linux-x86_64" -o /usr/local/bin/docker-compose

sudo chmod +x /usr/local/bin/docker-compose


# Verify versions
docker --version
docker-compose --version

# Install dependencies
sudo yum install -y wget curl unzip

# Install Trivy using RPM (recommended for Amazon Linux 2)
wget https://github.com/aquasecurity/trivy/releases/latest/download/trivy_0.51.1_Linux-64bit.rpm
sudo rpm -ivh trivy_0.51.1_Linux-64bit.rpm

# Verify installation
trivy --version