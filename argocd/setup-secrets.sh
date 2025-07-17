#!/bin/bash

# Script to set up secrets for Argo CD

# Check if required environment variables are set
if [ -z "$DOCKERHUB_USERNAME" ] || [ -z "$DOCKERHUB_PASSWORD" ]; then
  echo "Error: DOCKERHUB_USERNAME and DOCKERHUB_PASSWORD environment variables must be set"
  echo "Usage: DOCKERHUB_USERNAME=user DOCKERHUB_PASSWORD=pass ./setup-secrets.sh"
  exit 1
fi

# Create secrets for each environment
for ENV in dev test prod; do
  NAMESPACE="arcade-game-$ENV"
  
  # Create namespace if it doesn't exist
  kubectl create namespace $NAMESPACE --dry-run=client -o yaml | kubectl apply -f -
  
  # Create Docker registry secret
  kubectl create secret docker-registry dockerhub-credentials \
    --docker-server=https://index.docker.io/v1/ \
    --docker-username=$DOCKERHUB_USERNAME \
    --docker-password=$DOCKERHUB_PASSWORD \
    --docker-email=$DOCKERHUB_USERNAME@example.com \
    --namespace=$NAMESPACE \
    --dry-run=client -o yaml | kubectl apply -f -
    
  echo "Created Docker registry secret in namespace $NAMESPACE"
done

# Create Argo CD secret for Docker Hub credentials
kubectl create secret generic dockerhub-creds \
  --from-literal=username=$DOCKERHUB_USERNAME \
  --from-literal=password=$DOCKERHUB_PASSWORD \
  --namespace=argocd \
  --dry-run=client -o yaml | kubectl apply -f -
  
echo "Created Docker Hub credentials secret in argocd namespace"

# Create Argo CD secret for environment variables
cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: Secret
metadata:
  name: argocd-env-secret
  namespace: argocd
  labels:
    app.kubernetes.io/part-of: argocd
type: Opaque
stringData:
  DOCKERHUB_USERNAME: "$DOCKERHUB_USERNAME"
  DOCKERHUB_PASSWORD: "$DOCKERHUB_PASSWORD"
EOF

echo "Created environment variables secret in argocd namespace"

# Patch Argo CD repo server to use the environment variables
kubectl patch deployment argocd-repo-server -n argocd --type=json -p='[
  {
    "op": "add",
    "path": "/spec/template/spec/containers/0/env",
    "value": [
      {
        "name": "DOCKERHUB_USERNAME",
        "valueFrom": {
          "secretKeyRef": {
            "name": "argocd-env-secret",
            "key": "DOCKERHUB_USERNAME"
          }
        }
      },
      {
        "name": "DOCKERHUB_PASSWORD",
        "valueFrom": {
          "secretKeyRef": {
            "name": "argocd-env-secret",
            "key": "DOCKERHUB_PASSWORD"
          }
        }
      }
    ]
  }
]'

echo "Patched Argo CD repo server to use environment variables"