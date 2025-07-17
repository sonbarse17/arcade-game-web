#!/bin/bash

# Script to generate monitoring reports

# Default values
NAMESPACE="arcade-game-prod"
OUTPUT_DIR="./reports"
PERIOD="24h"

# Parse command line arguments
while [[ $# -gt 0 ]]; do
  key="$1"
  case $key in
    -n|--namespace)
      NAMESPACE="$2"
      shift
      shift
      ;;
    -o|--output)
      OUTPUT_DIR="$2"
      shift
      shift
      ;;
    -p|--period)
      PERIOD="$2"
      shift
      shift
      ;;
    *)
      echo "Unknown option: $1"
      exit 1
      ;;
  esac
done

# Create output directory if it doesn't exist
mkdir -p "$OUTPUT_DIR"

# Get current date for report filename
DATE=$(date +"%Y-%m-%d")
REPORT_FILE="$OUTPUT_DIR/monitoring-report-$NAMESPACE-$DATE.txt"

echo "Generating monitoring report for $NAMESPACE for the last $PERIOD..."
echo "Report will be saved to $REPORT_FILE"

# Start the report
echo "=== Arcade Game Monitoring Report ===" > "$REPORT_FILE"
echo "Namespace: $NAMESPACE" >> "$REPORT_FILE"
echo "Period: Last $PERIOD" >> "$REPORT_FILE"
echo "Date: $DATE" >> "$REPORT_FILE"
echo "" >> "$REPORT_FILE"

# Get pod resource usage
echo "=== Pod Resource Usage ===" >> "$REPORT_FILE"
kubectl top pods -n "$NAMESPACE" >> "$REPORT_FILE"
echo "" >> "$REPORT_FILE"

# Get node resource usage
echo "=== Node Resource Usage ===" >> "$REPORT_FILE"
kubectl top nodes >> "$REPORT_FILE"
echo "" >> "$REPORT_FILE"

# Get recent errors from logs
echo "=== Recent Errors ===" >> "$REPORT_FILE"
kubectl logs --tail=100 -n "$NAMESPACE" -l app.kubernetes.io/name=arcade-game | grep -i error >> "$REPORT_FILE" 2>/dev/null || echo "No errors found in logs" >> "$REPORT_FILE"
echo "" >> "$REPORT_FILE"

# Get HPA status
echo "=== Horizontal Pod Autoscaler Status ===" >> "$REPORT_FILE"
kubectl get hpa -n "$NAMESPACE" >> "$REPORT_FILE" 2>/dev/null || echo "No HPAs found" >> "$REPORT_FILE"
echo "" >> "$REPORT_FILE"

# Get recent alerts
echo "=== Recent Alerts ===" >> "$REPORT_FILE"
PROMETHEUS_POD=$(kubectl get pods -n monitoring -l app=prometheus -o jsonpath="{.items[0].metadata.name}")
kubectl exec -n monitoring "$PROMETHEUS_POD" -c prometheus-server -- wget -qO- http://localhost:9090/api/v1/alerts | grep -i "arcade-game" >> "$REPORT_FILE" 2>/dev/null || echo "No active alerts" >> "$REPORT_FILE"

echo "Report generated successfully at $REPORT_FILE"