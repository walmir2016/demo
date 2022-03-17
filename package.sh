#!/bin/bash

# Define packaging environment.
export ETC_DIR=./backend/etc

# Define RASP configuration.
cp $ETC_DIR/contrast_security.yaml.template $ETC_DIR/contrast_security.yaml

sed -i -e 's|${CONTRAST_API_KEY}|'"$CONTRAST_API_KEY"'|g' $ETC_DIR/contrast_security.yaml
sed -i -e 's|${CONTRAST_SERVICE_KEY}|'"$CONTRAST_SERVICE_KEY"'|g' $ETC_DIR/contrast_security.yaml
sed -i -e 's|${CONTRAST_USER_NAME}|'"$CONTRAST_USER_NAME"'|g' $ETC_DIR/contrast_security.yaml

# Define monitoring (Datadog) configuration.
echo $DATADOG_AGENT_KEY > $ETC_DIR/datadog_agent.ini

# Build docker images.
docker-compose -f ./iac/docker-compose.yml build

# Clean temporary files.
rm $ETC_DIR/contrast_security.yaml
rm $ETC_DIR/datadog_agent.ini