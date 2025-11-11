#!/bin/bash
# Update and install Docker + Compose
sudo apt update -y
sudo apt install -y docker.io docker-compose

# Enable Docker
sudo systemctl start docker
sudo systemctl enable docker

# Create directory for the app
mkdir -p /home/ubuntu/app
cd /home/ubuntu/app

# Write docker-compose.yml from Terraform
cat <<EOF > docker-compose.yml
${docker_compose}
EOF

# Run containers
sudo docker-compose up -d
