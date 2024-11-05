#!/bin/bash

CWD=$(basename "$PWD")

# Enforce ownership and permissions
sudo chmod go-w configs/filebeat.yml
sudo chmod go-w configs/metricbeat.yml
sudo chown root: configs/metricbeat.yml
sudo chown root: configs/filebeat.yml

# Start the environment and force Docker image recreation
docker compose up -d --build --force-recreate

# Hold the script running for 60 seconds
sleep 60

# Download the certificate and test Elasticsearch connectivity
docker cp "$CWD-es01-1":/usr/share/elasticsearch/config/certs/ca/ca.crt .
curl -s --cacert ./ca.crt -u elastic:changeme "https://localhost:9200"
