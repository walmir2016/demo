#!/bin/bash

SNYK_CMD=`which snyk`

if [ -z "SNYK_CMD" ]; then
  SNYK_CMD=./snyk

$SNYK_CMD container monitor $DOCKER_REGISTRY_URL/$DOCKER_REGISTRY_USERNAME/demo:latest