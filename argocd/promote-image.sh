#!/bin/bash

# Script to promote images between environments

# Default values
SOURCE_ENV="dev"
TARGET_ENV="test"

# Parse command line arguments
while [[ $# -gt 0 ]]; do
  key="$1"
  case $key in
    -s|--source)
      SOURCE_ENV="$2"
      shift
      shift
      ;;
    -t|--target)
      TARGET_ENV="$2"
      shift
      shift
      ;;
    *)
      echo "Unknown option: $1"
      exit 1
      ;;
  esac
done

# Validate environments
if [[ "$SOURCE_ENV" != "dev" && "$SOURCE_ENV" != "test" && "$SOURCE_ENV" != "prod" ]]; then
  echo "Error: Source environment must be one of: dev, test, prod"
  echo "Usage: ./promote-image.sh --source [dev|test|prod] --target [dev|test|prod]"
  exit 1
fi

if [[ "$TARGET_ENV" != "dev" && "$TARGET_ENV" != "test" && "$TARGET_ENV" != "prod" ]]; then
  echo "Error: Target environment must be one of: dev, test, prod"
  echo "Usage: ./promote-image.sh --source [dev|test|prod] --target [dev|test|prod]"
  exit 1
fi

if [[ "$SOURCE_ENV" == "$TARGET_ENV" ]]; then
  echo "Error: Source and target environments cannot be the same"
  exit 1
fi

# Login to ArgoCD if credentials are provided
if [[ -n "$ARGOCD_SERVER" && -n "$ARGOCD_USERNAME" && -n "$ARGOCD_PASSWORD" ]]; then
  echo "Logging in to ArgoCD..."
  argocd login $ARGOCD_SERVER --username $ARGOCD_USERNAME --password $ARGOCD_PASSWORD --insecure
fi

# Get current image tag from source environment
echo "Getting current image tag from $SOURCE_ENV environment..."
SOURCE_IMAGE_TAG=$(argocd app get arcade-game-$SOURCE_ENV -o json | jq -r '.spec.source.helm.parameters[] | select(.name == "image.tag") | .value')

if [[ -z "$SOURCE_IMAGE_TAG" ]]; then
  echo "Error: Could not get image tag from source environment"
  exit 1
fi

echo "Found image tag: $SOURCE_IMAGE_TAG"

# Update image tag in target environment
echo "Updating image tag in $TARGET_ENV environment..."
argocd app set arcade-game-$TARGET_ENV -p image.tag=$SOURCE_IMAGE_TAG

# Sync target application
echo "Syncing $TARGET_ENV application..."
argocd app sync arcade-game-$TARGET_ENV

echo "Image promoted successfully from $SOURCE_ENV to $TARGET_ENV!"