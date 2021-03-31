#!/bin/bash
# Publish the docker image in Github packages.
# When it runs in github actions, all environments variables must have a secret with the same name.
#
# **** WARNING *****
# DON'T EXPOSE OR COMMIT ANY VARIABLE IN THE PROJECT.
#
# If you will run locally, set the environment variables in the .bash_profile.
# Environment variables used:
# - DOCKER_REGISTRY_URL: URL of the registry that stores the docker images.
# - DOCKER_REGISTRY_USERNAME: User name to connect in the registry.
# - DOCKER_REGISTRY_PASSWORD: Password to connect in the registry.
echo $DOCKER_REGISTRY_PASSWORD | docker login -u $DOCKER_REGISTRY_USERNAME $DOCKER_REGISTRY_URL --password-stdin
docker-compose push