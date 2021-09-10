#!/bin/bash

SNYK_CMD=`which snyk`

if [ -z "$SNYK_CMD" ]; then
  SNYK_CMD=./snyk
fi

$SNYK_CMD container monitor $DOCKER_REGISTRY_URL/$DOCKER_REGISTRY_USERNAME/demo-database:latest
$SNYK_CMD container monitor $DOCKER_REGISTRY_URL/$DOCKER_REGISTRY_USERNAME/demo-backend:latest
$SNYK_CMD container monitor $DOCKER_REGISTRY_URL/$DOCKER_REGISTRY_USERNAME/demo-frontend:latest