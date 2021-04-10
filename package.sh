#!/bin/bash

mkdir etc
echo "$CONTRAST_CONFIG_DATA" > etc/contrast_security.yaml
docker build -t $DOCKER_REGISTRY_URL/$DOCKER_REGISTRY_USERNAME/demo:latest .
rm -rf etc