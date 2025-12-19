#!/bin/bash
# Pre-Install Check Template: Docker and Docker Compose
#
# This script checks if Docker and Docker Compose are available and running.
# Uncomment and modify the sections below to use in your project.

# echo "Checking Docker installation..."

# Example: Check if docker command is available
# if ! command -v docker >/dev/null 2>&1; then
#     echo "Error: Docker not found"
#     echo ""
#     echo "Install Docker:"
#     echo "  Visit: https://docs.docker.com/engine/install/"
#     echo "  Or use convenience script:"
#     echo "    curl -fsSL https://get.docker.com -o get-docker.sh"
#     echo "    sudo sh get-docker.sh"
#     exit 1
# fi
# echo "✓ Docker installed"

# Example: Check if Docker daemon is running
# if ! docker info >/dev/null 2>&1; then
#     echo "Error: Docker daemon is not running"
#     echo ""
#     echo "Start Docker daemon:"
#     echo "  sudo systemctl start docker"
#     echo "  sudo systemctl enable docker"
#     exit 1
# fi
# echo "✓ Docker daemon running"

# Example: Check if user is in docker group
# if ! groups | grep -q docker; then
#     echo "Warning: Current user is not in 'docker' group"
#     echo ""
#     echo "Add user to docker group (avoids using sudo):"
#     echo "  sudo usermod -aG docker $USER"
#     echo "  newgrp docker"
#     echo ""
#     echo "Note: You may need to log out and back in"
# fi

# Example: Check Docker version
# DOCKER_VERSION=$(docker --version | grep -oP '\d+\.\d+\.\d+' | head -1)
# echo "  Docker version: $DOCKER_VERSION"

# Example: Check minimum Docker version
# MIN_DOCKER_VERSION="20.10.0"
# CURRENT_VERSION=$(docker --version | grep -oP '\d+\.\d+\.\d+' | head -1)
# if [ "$(printf '%s\n' "$MIN_DOCKER_VERSION" "$CURRENT_VERSION" | sort -V | head -n1)" != "$MIN_DOCKER_VERSION" ]; then
#     echo "Error: Docker version $CURRENT_VERSION is too old"
#     echo "Minimum required version: $MIN_DOCKER_VERSION"
#     exit 1
# fi

# Example: Check if Docker Compose is available
# if ! command -v docker-compose >/dev/null 2>&1 && ! docker compose version >/dev/null 2>&1; then
#     echo "Error: Docker Compose not found"
#     echo ""
#     echo "Install Docker Compose:"
#     echo "  Visit: https://docs.docker.com/compose/install/"
#     exit 1
# fi
# echo "✓ Docker Compose installed"

# Example: Show Docker Compose version
# if command -v docker-compose >/dev/null 2>&1; then
#     COMPOSE_VERSION=$(docker-compose --version | grep -oP '\d+\.\d+\.\d+' | head -1)
#     echo "  Docker Compose version: $COMPOSE_VERSION"
# else
#     COMPOSE_VERSION=$(docker compose version --short 2>/dev/null)
#     echo "  Docker Compose version: $COMPOSE_VERSION (plugin)"
# fi

echo "Docker check completed successfully!"
exit 0
