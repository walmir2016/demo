#!/bin/bash

# Authenticate in the packaging repository.
echo $REPOSITORY_PASSWORD | docker login -u $REPOSITORY_USER $REPOSITORY_URL --password-stdin

# Tag the version in the packages and push into the repository
BUILD_VERSION=$(md5sum -b /tmp/demo-database.tar | awk '{print $1}')
docker tag $REPOSITORY_URL/$REPOSITORY_ID/demo-database:latest $REPOSITORY_URL/$REPOSITORY_ID/demo-database:$BUILD_VERSION
docker push $REPOSITORY_URL/$REPOSITORY_ID/demo-database:$BUILD_VERSION

BUILD_VERSION=$(md5sum -b /tmp/demo-backend.tar | awk '{print $1}')
docker tag $REPOSITORY_URL/$REPOSITORY_ID/demo-backend:latest $REPOSITORY_URL/$REPOSITORY_ID/demo-backend:$BUILD_VERSION
docker push $REPOSITORY_URL/$REPOSITORY_ID/demo-backend:$BUILD_VERSION

BUILD_VERSION=$(md5sum -b /tmp/demo-frontend.tar | awk '{print $1}')
docker tag $REPOSITORY_URL/$REPOSITORY_ID/demo-frontend:latest $REPOSITORY_URL/$REPOSITORY_ID/demo-frontend:$BUILD_VERSION
docker push $REPOSITORY_URL/$REPOSITORY_ID/demo-frontend:$BUILD_VERSION

docker-compose -f ./iac/docker-compose.yml push