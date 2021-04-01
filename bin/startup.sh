#!/bin/bash

export CATALINA_OPTS="$CATALINA_OPTS -javaagent:/home/user/lib/contrast.jar"

/opt/apache-tomcat/bin/catalina.sh jpda run