# HTML5 Arcade Game Helm Chart

This Helm chart deploys the HTML5 Arcade Game to Kubernetes with support for multiple environments (dev, test, prod).

## Prerequisites

- Kubernetes 1.19+
- Helm 3.2.0+
- Kubectl configured to connect to your Kubernetes cluster

## Installation

### Quick Start

```bash
# Deploy to dev environment
./deploy.sh dev

# Deploy to test environment
./deploy.sh test

# Deploy to production environment
./deploy.sh prod
```

### Manual Installation

```bash
# Create namespace
kubectl create namespace arcade-game-dev

# Install chart with dev values
helm install arcade-game-dev ./arcade-game --namespace arcade-game-dev --values ./arcade-game/values-dev.yaml
```

## Configuration

The following table lists the configurable parameters for each environment:

| Environment | Replicas | Resources | Autoscaling | Ingress Host |
|-------------|----------|-----------|-------------|--------------|
| Dev         | 1        | Low       | Disabled    | dev.arcade-game.example.com |
| Test        | 2        | Medium    | Enabled     | test.arcade-game.example.com |
| Prod        | 3        | High      | Enabled     | arcade-game.example.com |

## Uninstallation

```bash
helm uninstall arcade-game-dev --namespace arcade-game-dev
```