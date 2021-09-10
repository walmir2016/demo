#!/bin/bash

docker scan --token $SNYK_TOKEN $DOCKER_REGISTRY_URL/$DOCKER_REGISTRY_USER/demo-database:latest
docker scan --token $SNYK_TOKEN $DOCKER_REGISTRY_URL/$DOCKER_REGISTRY_USER/demo-backend:latest
docker scan --token $SNYK_TOKEN $DOCKER_REGISTRY_URL/$DOCKER_REGISTRY_USER/demo-frontend:latest