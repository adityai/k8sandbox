# Kubernetes Sandbox

A simple local Kubernetes development environment using Kind (Kubernetes IN Docker).

## Prerequisites

- Docker installed and running
- macOS or Linux (supports both ARM64 and AMD64 architectures)

## Quick Start

Run the setup script to create your local Kubernetes cluster:

```bash
./run.sh
```

## What it does

The `run.sh` script:

1. Verifies Docker is installed and running
2. Checks and installs Kind (Kubernetes IN Docker) if not present
3. Checks and installs kubectl if not present
4. Creates a Kubernetes cluster named "sandbox"
5. Verifies the cluster is running
6. Provides confirmation and usage instructions

## Usage

After running the script, interact with your cluster using kubectl:

```bash
# View cluster information
kubectl cluster-info --context kind-sandbox

# Get nodes
kubectl get nodes

# Get all resources
kubectl get all --all-namespaces
```

## Cleanup

To remove the sandbox cluster:

```bash
kind delete cluster --name sandbox
```

## Notes

- The script automatically detects your OS and architecture (ARM64/AMD64)
- Supports both macOS and Linux systems
- The cluster context is automatically set to `kind-sandbox`