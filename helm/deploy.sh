#!/bin/bash

# Script to deploy the arcade-game to different environments

# Usage: ./deploy.sh [dev|test|prod]

# Default to dev if no environment specified
ENV=${1:-dev}

# Validate environment
if [[ "$ENV" != "dev" && "$ENV" != "test" && "$ENV" != "prod" ]]; then
  echo "Error: Environment must be one of: dev, test, prod"
  echo "Usage: ./deploy.sh [dev|test|prod]"
  exit 1
fi

# Set namespace based on environment
NAMESPACE="arcade-game-$ENV"

# Create namespace if it doesn't exist
kubectl create namespace $NAMESPACE --dry-run=client -o yaml | kubectl apply -f -

# Deploy using Helm
echo "Deploying to $ENV environment in namespace $NAMESPACE..."
helm upgrade --install arcade-game-$ENV ./arcade-game \
  --namespace $NAMESPACE \
  --values ./arcade-game/values-$ENV.yaml \
  --set image.tag=$(git rev-parse --short HEAD) \
  --wait

# Check deployment status
kubectl get all -n $NAMESPACE

echo "Deployment to $ENV complete!"