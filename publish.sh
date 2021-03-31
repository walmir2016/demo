#!/bin/bash

echo $DOCKER_REGISTRY_PASSWORD | docker login -u $DOCKER_REGISTRY_USERNAME $DOCKER_REGISTRY_URL --password-stdin

docker-compose push