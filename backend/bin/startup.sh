#!/bin/bash

CATALINA_OPTS="-Xdebug -Xrunjdwp:transport=dt_socket,address=8000,server=y,suspend=n"

/opt/apache-tomcat/bin/catalina.sh jpda run