#!/bin/bash

docker scan --accept-license --severity high --token $SNYK_TOKEN $DOCKER_REGISTRY_URL/$DOCKER_REGISTRY_USER/demo-database:latest
docker scan --accept-license --severity high --token $SNYK_TOKEN $DOCKER_REGISTRY_URL/$DOCKER_REGISTRY_USER/demo-backend:latest
docker scan --accept-license --severity high --token $SNYK_TOKEN $DOCKER_REGISTRY_URL/$DOCKER_REGISTRY_USER/demo-frontend:latest