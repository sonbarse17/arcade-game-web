#!/bin/bash

# Script to deploy applications to Argo CD

# Default values
ENVIRONMENT="dev"
SYNC=false

# Parse command line arguments
while [[ $# -gt 0 ]]; do
  key="$1"
  case $key in
    -e|--environment)
      ENVIRONMENT="$2"
      shift
      shift
      ;;
    -s|--sync)
      SYNC=true
      shift
      ;;
    *)
      echo "Unknown option: $1"
      exit 1
      ;;
  esac
done

# Validate environment
if [[ "$ENVIRONMENT" != "dev" && "$ENVIRONMENT" != "test" && "$ENVIRONMENT" != "prod" && "$ENVIRONMENT" != "all" ]]; then
  echo "Error: Environment must be one of: dev, test, prod, all"
  echo "Usage: ./deploy.sh --environment [dev|test|prod|all] [--sync]"
  exit 1
fi

# Deploy applications
if [[ "$ENVIRONMENT" == "all" ]]; then
  echo "Deploying all applications to Argo CD..."
  kubectl apply -f applicationset.yaml -n argocd
else
  echo "Deploying $ENVIRONMENT application to Argo CD..."
  kubectl apply -f applications/$ENVIRONMENT-application.yaml -n argocd
fi

# Sync applications if requested
if [[ "$SYNC" == true ]]; then
  # Login to ArgoCD if credentials are provided
  if [[ -n "$ARGOCD_SERVER" && -n "$ARGOCD_USERNAME" && -n "$ARGOCD_PASSWORD" ]]; then
    echo "Logging in to ArgoCD..."
    argocd login $ARGOCD_SERVER --username $ARGOCD_USERNAME --password $ARGOCD_PASSWORD --insecure
  fi
  
  if [[ "$ENVIRONMENT" == "all" ]]; then
    echo "Syncing all applications..."
    argocd app sync arcade-game-dev
    argocd app sync arcade-game-test
    argocd app sync arcade-game-prod
  else
    echo "Syncing $ENVIRONMENT application..."
    argocd app sync arcade-game-$ENVIRONMENT
  fi
fi

echo "Deployment complete!"