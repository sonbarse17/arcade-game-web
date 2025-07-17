#!/bin/bash

# Script to install Argo CD in the cluster

# Create namespace for Argo CD
kubectl create namespace argocd

# Install Argo CD
echo "Installing Argo CD..."
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

# Wait for Argo CD to be ready
echo "Waiting for Argo CD to be ready..."
kubectl wait --for=condition=available --timeout=300s deployment/argocd-server -n argocd

# Get the initial admin password
echo "Getting initial admin password..."
ARGOCD_PASSWORD=$(kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d)

# Expose Argo CD server
echo "Exposing Argo CD server..."
kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "LoadBalancer"}}'

# Get the Argo CD server URL
echo "Waiting for LoadBalancer IP..."
sleep 10
ARGOCD_SERVER_IP=$(kubectl get svc argocd-server -n argocd -o jsonpath="{.status.loadBalancer.ingress[0].ip}")

echo ""
echo "Argo CD has been installed successfully!"
echo "Server: https://$ARGOCD_SERVER_IP"
echo "Username: admin"
echo "Password: $ARGOCD_PASSWORD"
echo ""
echo "To login using the CLI:"
echo "argocd login $ARGOCD_SERVER_IP --username admin --password $ARGOCD_PASSWORD --insecure"
echo ""
echo "Remember to change the default password!"