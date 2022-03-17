#!/bin/bash

# Authenticate in the packaging repository.
echo $REPOSITORY_PASSWORD | docker login -u $REPOSITORY_USER --password-stdin

# Push the packages into the repository.
docker-compose -f ./iac/docker-compose.yml push
