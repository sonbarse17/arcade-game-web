# Monitoring Setup for HTML5 Arcade Game

This directory contains configuration files for setting up Prometheus and Grafana to monitor the HTML5 Arcade Game in Kubernetes.

## Components

- **Prometheus**: For metrics collection and alerting
- **Grafana**: For visualization and dashboards
- **ServiceMonitor**: For configuring Prometheus to scrape metrics from the application

## Setup Instructions

1. Make sure you have Helm installed and configured with your Kubernetes cluster.

2. Run the setup script:

```bash
# Make the script executable
chmod +x setup-monitoring.sh

# Run the script
./setup-monitoring.sh
```

3. Access the monitoring tools:

   - **Prometheus**: Forward port 9090 and access via http://localhost:9090
   - **Grafana**: Forward port 3000 and access via http://localhost:3000

## Included Dashboards

The Grafana setup includes pre-configured dashboards for the HTML5 Arcade Game:

### Application Dashboard
- HTTP request rate metrics
- Error rate metrics
- Response time metrics

### Resource Usage Dashboard
- CPU usage by pod
- Memory usage by pod
- CPU requests vs limits by namespace
- Memory requests vs limits by namespace

## Alerting

Prometheus is configured with the following alerts:

- **HighCPUUsage**: Triggers when CPU usage exceeds 80% for 5 minutes
- **HighMemoryUsage**: Triggers when memory usage exceeds 80% for 5 minutes

## Alert Notifications

AlertManager is configured to send notifications to Slack when alerts are triggered. To configure Slack notifications:

1. Create a Slack webhook URL in your Slack workspace
2. Update the `alertmanager-values.yaml` file with your webhook URL
3. Run the setup script to apply the changes

## Customization

To customize the monitoring setup:

1. Edit `prometheus-values.yaml` to modify Prometheus configuration
2. Edit `grafana-values.yaml` to modify Grafana configuration or add new dashboards
3. Edit `service-monitor.yaml` to change which services are monitored
4. Edit `alertmanager-values.yaml` to modify alert notification settings

## Utilities

The monitoring setup includes several utility scripts:

- `setup-monitoring.sh`: Installs and configures the monitoring stack
- `check-monitoring.sh`: Checks the health of the monitoring components
- `generate-report.sh`: Generates a monitoring report for a specific namespace

### Generating Reports

```bash
# Generate a report for the production environment
./generate-report.sh --namespace arcade-game-prod --period 24h --output ./reports
```