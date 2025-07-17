#!/bin/bash

# Script to set up ELK stack for observability

# Create namespace
kubectl create namespace elk

# Use provided password or generate a random one
if [[ -z "$ELASTIC_PASSWORD" ]]; then
  echo "No password provided, generating a random one..."
  ELASTIC_PASSWORD=$(openssl rand -base64 16)
else
  echo "Using provided Elasticsearch password"
fi

# Create secret for Elasticsearch credentials
kubectl create secret generic elasticsearch-credentials \
  --from-literal=password=$ELASTIC_PASSWORD \
  --namespace elk

# Add Elastic Helm repo
helm repo add elastic https://helm.elastic.co
helm repo update

# Install Elasticsearch
echo "Installing Elasticsearch..."
helm install elasticsearch elastic/elasticsearch \
  --namespace elk \
  --values elasticsearch-values.yaml

# Wait for Elasticsearch to be ready
echo "Waiting for Elasticsearch to be ready..."
kubectl wait --for=condition=ready pod -l app=elasticsearch-master --timeout=300s --namespace elk

# Install Kibana
echo "Installing Kibana..."
helm install kibana elastic/kibana \
  --namespace elk \
  --values kibana-values.yaml

# Create Kibana dashboard ConfigMap
kubectl create configmap kibana-dashboard-arcade-game \
  --from-file=arcade-game-overview.json=kibana-dashboard.json \
  --namespace elk

# Install Logstash
echo "Installing Logstash..."
helm install logstash elastic/logstash \
  --namespace elk \
  --values logstash-values.yaml

# Install Filebeat
echo "Installing Filebeat..."
helm install filebeat elastic/filebeat \
  --namespace elk \
  --values filebeat-values.yaml

# Get access information
echo ""
echo "ELK Stack has been installed successfully!"
echo ""
echo "Elasticsearch:"
echo "  URL: http://elasticsearch-master.elk:9200"
echo "  Username: elastic"
echo "  Password: $ELASTIC_PASSWORD"
echo ""
echo "Kibana:"
echo "  URL: http://kibana.arcade-game.example.com"
echo "  Username: elastic"
echo "  Password: $ELASTIC_PASSWORD"
echo ""
echo "To access Kibana locally:"
echo "  kubectl port-forward svc/kibana-kibana 5601:5601 -n elk"
echo "  Then open http://localhost:5601 in your browser"