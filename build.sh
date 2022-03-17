#!/bin/bash

# Generate the version tag.
export BUILD_VERSION=$(date | md5sum | awk '{print $1}')

echo "BUILD_VERSION=$BUILD_VERSION" > ./iac/.env

# Compile, build and test the code.
./gradlew clean build

# Clear unused files.
rm -f ./backend/build/libs/*plain.war