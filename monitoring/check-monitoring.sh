#!/bin/bash

# Script to check the health of the monitoring stack

echo "Checking Prometheus..."
kubectl get pods -n monitoring -l app=prometheus -o wide

echo -e "\nChecking Grafana..."
kubectl get pods -n monitoring -l app.kubernetes.io/name=grafana -o wide

echo -e "\nChecking AlertManager..."
kubectl get pods -n monitoring -l app=prometheus-alertmanager -o wide

echo -e "\nChecking ServiceMonitors..."
kubectl get servicemonitors --all-namespaces

echo -e "\nChecking Prometheus targets..."
PROMETHEUS_POD=$(kubectl get pods -n monitoring -l app=prometheus -o jsonpath="{.items[0].metadata.name}")
kubectl exec -n monitoring $PROMETHEUS_POD -c prometheus-server -- wget -qO- http://localhost:9090/api/v1/targets | grep "state"