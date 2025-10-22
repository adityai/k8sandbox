#!/bin/bash

# This script sets up a local Kubernetes sandbox using Kind (Kubernetes IN Docker)

# Ensure Docker is installed and running; exit if not
if ! command -v docker &> /dev/null; then
    echo "Docker must be installed and running. Aborting."
    exit 1
fi

# Check if kind is installed
if ! command -v kind &> /dev/null; then
    echo "Installing kind..."
    ARCH=$(uname -m)
    OS=$(uname -s | tr '[:upper:]' '[:lower:]')
    
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
else
    echo "kind is already installed"
fi

# Check if kubectl is installed
if ! command -v kubectl &> /dev/null; then
    echo "Installing kubectl..."
    ARCH=$(uname -m)
    OS=$(uname -s | tr '[:upper:]' '[:lower:]')
    
    if [ "$ARCH" = "arm64" ]; then
        curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/${OS}/arm64/kubectl"
    elif [ "$ARCH" = "x86_64" ]; then
        curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/${OS}/amd64/kubectl"
    else
        echo "Unsupported architecture: $ARCH"
        exit 1
    fi
    
    chmod +x ./kubectl
    sudo mv ./kubectl /usr/local/bin/kubectl
else
    echo "kubectl is already installed"
fi

# Check if cluster already exists
if kind get clusters | grep -q "^sandbox$"; then
    echo "Cluster 'sandbox' is already running"
else
    echo "Creating cluster 'sandbox'..."
    kind create cluster --name sandbox
fi

# Verify the cluster is running
kubectl cluster-info --context kind-sandbox

echo "Kubernetes sandbox is ready!"
echo "To interact, use 'kubectl' (e.g., kubectl get nodes)"
