#!/bin/bash

export JPDA_OPTS="$JPDA_OPTS -agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=0.0.0.0:8000"
export CATALINA_OPTS="$CATALINA_OPTS -javaagent:/home/user/lib/contrast.jar"

/opt/apache-tomcat/bin/catalina.sh jpda run