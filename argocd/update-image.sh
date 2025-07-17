#!/bin/bash

# Script to update image tags in Argo CD applications

# Default values
ENVIRONMENT="dev"
IMAGE_TAG=""

# Parse command line arguments
while [[ $# -gt 0 ]]; do
  key="$1"
  case $key in
    -e|--environment)
      ENVIRONMENT="$2"
      shift
      shift
      ;;
    -t|--tag)
      IMAGE_TAG="$2"
      shift
      shift
      ;;
    *)
      echo "Unknown option: $1"
      exit 1
      ;;
  esac
done

# Validate inputs
if [[ -z "$IMAGE_TAG" ]]; then
  echo "Error: Image tag is required"
  echo "Usage: ./update-image.sh --environment [dev|test|prod] --tag [IMAGE_TAG]"
  exit 1
fi

if [[ "$ENVIRONMENT" != "dev" && "$ENVIRONMENT" != "test" && "$ENVIRONMENT" != "prod" ]]; then
  echo "Error: Environment must be one of: dev, test, prod"
  echo "Usage: ./update-image.sh --environment [dev|test|prod] --tag [IMAGE_TAG]"
  exit 1
fi

# Login to ArgoCD if credentials are provided
if [[ -n "$ARGOCD_SERVER" && -n "$ARGOCD_USERNAME" && -n "$ARGOCD_PASSWORD" ]]; then
  echo "Logging in to ArgoCD..."
  argocd login $ARGOCD_SERVER --username $ARGOCD_USERNAME --password $ARGOCD_PASSWORD --insecure
fi

# Update image tag in Argo CD application
echo "Updating image tag for arcade-game-$ENVIRONMENT to $IMAGE_TAG..."
argocd app set arcade-game-$ENVIRONMENT -p image.tag=$IMAGE_TAG

# Sync application if requested
echo "Syncing application..."
argocd app sync arcade-game-$ENVIRONMENT

echo "Image tag updated successfully!"