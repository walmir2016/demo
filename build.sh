#!/bin/bash

gradlew clean build sonarqube --info

docker build -t ghcr.io/fvilarinho/demo:latest .