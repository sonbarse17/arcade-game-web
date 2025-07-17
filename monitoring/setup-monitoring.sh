#!/bin/bash

# Script to set up Prometheus and Grafana monitoring

# Create monitoring namespace
kubectl create namespace monitoring

# Add Prometheus Helm repo
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo add grafana https://grafana.github.io/helm-charts
helm repo update

# Install Prometheus with AlertManager
echo "Installing Prometheus and AlertManager..."
helm upgrade --install prometheus prometheus-community/prometheus \
  --namespace monitoring \
  --values prometheus-values.yaml \
  --set alertmanager.configFromSecret=alertmanager-config \
  --set alertmanager.persistentVolume.size=2Gi

# Create AlertManager config secret
kubectl create secret generic alertmanager-config \
  --from-file=alertmanager.yml=alertmanager-values.yaml \
  --namespace monitoring \
  --dry-run=client -o yaml | kubectl apply -f -

# Install Grafana
echo "Installing Grafana..."
helm upgrade --install grafana grafana/grafana \
  --namespace monitoring \
  --values grafana-values.yaml

# Apply ServiceMonitor
kubectl apply -f service-monitor.yaml -n monitoring

# Wait for deployments to be ready
echo "Waiting for Prometheus and Grafana to be ready..."
kubectl rollout status deployment/prometheus-server -n monitoring
kubectl rollout status deployment/grafana -n monitoring

# Get Grafana admin password
GRAFANA_PASSWORD=$(kubectl get secret --namespace monitoring grafana -o jsonpath="{.data.admin-password}" | base64 --decode)

# Get access URLs
echo ""
echo "Prometheus and Grafana have been installed!"
echo ""
echo "To access Prometheus:"
echo "  kubectl port-forward svc/prometheus-server 9090:80 -n monitoring"
echo "  Then open http://localhost:9090 in your browser"
echo ""
echo "To access Grafana:"
echo "  kubectl port-forward svc/grafana 3000:80 -n monitoring"
echo "  Then open http://localhost:3000 in your browser"
echo "  Username: admin"
echo "  Password: $GRAFANA_PASSWORD"