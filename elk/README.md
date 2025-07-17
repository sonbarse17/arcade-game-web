# ELK Stack for HTML5 Arcade Game

This directory contains configuration files for setting up the ELK (Elasticsearch, Logstash, Kibana) stack for observability of the HTML5 Arcade Game.

## Components

- **Elasticsearch**: For storing and indexing logs
- **Logstash**: For log processing and transformation
- **Kibana**: For visualization and dashboards
- **Filebeat**: For collecting logs from Kubernetes pods

## Setup Instructions

1. Make sure you have Helm installed and configured with your Kubernetes cluster.

2. Run the setup script:

```bash
# Make the script executable
chmod +x setup-elk.sh

# Run the script
./setup-elk.sh
```

3. Access Kibana:

   - Through the ingress: http://kibana.arcade-game.example.com
   - Or using port-forwarding: `kubectl port-forward svc/kibana-kibana 5601:5601 -n elk`

## Log Collection

Filebeat is configured to collect logs from all pods in the arcade-game namespaces:
- arcade-game-dev
- arcade-game-test
- arcade-game-prod

Logs are processed by Logstash and stored in Elasticsearch with the following index pattern:
- `arcade-game-dev-YYYY.MM.dd`
- `arcade-game-test-YYYY.MM.dd`
- `arcade-game-prod-YYYY.MM.dd`

## Included Dashboards

The Kibana setup includes a pre-configured dashboard for the HTML5 Arcade Game with:
- Log volume by environment
- HTTP status codes
- Recent errors

## Customization

To customize the ELK stack:

1. Edit `elasticsearch-values.yaml` to modify Elasticsearch configuration
2. Edit `kibana-values.yaml` to modify Kibana configuration
3. Edit `logstash-values.yaml` to modify Logstash configuration and pipelines
4. Edit `filebeat-values.yaml` to modify log collection settings