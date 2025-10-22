#!/bin/bash

# This script sets up a local Kubernetes sandbox using Kind (Kubernetes IN Docker)

# Ensure Docker is installed and running; exit if not
if ! command -v docker &> /dev/null; then
    echo "Docker must be installed and running. Aborting."
    exit 1
fi

# Detect architecture and OS
ARCH=$(uname -m)
OS=$(uname -s | tr '[:upper:]' '[:lower:]')

# Download and install Kind based on architecture
if [ "$ARCH" = "arm64" ]; then
    curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.30.0/kind-${OS}-arm64
elif [ "$ARCH" = "x86_64" ]; then
    curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.30.0/kind-${OS}-amd64
else
    echo "Unsupported architecture: $ARCH"
    exit 1
fi

chmod +x ./kind
sudo mv ./kind /usr/local/bin/kind


# curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/darwin/arm64/kubectl"
# chmod +x ./kubectl
# sudo mv ./kubectl /usr/local/bin/kubectl

# Create the Kubernetes cluster
kind create cluster --name sandbox

# Verify the cluster is running
kubectl cluster-info --context kind-sandbox

echo "Kubernetes sandbox is ready!"
echo "To interact, use 'kubectl' (e.g., kubectl get nodes)"
