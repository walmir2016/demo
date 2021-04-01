#!/bin/bash
# Build the docker image.
mkdir etc
echo "$CONTRAST_CONFIG_DATA" > etc/contrast_security.yaml
docker-compose build
rm -rf etc