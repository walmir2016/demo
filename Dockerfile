# Define the base linux distribution.
FROM alpine:latest

# Define the Apache Tomcat version to be used.
ARG TOMCAT_MAJOR_VERSION=9
ARG TOMCAT_MINOR_VERSION=0.44
ARG TOMCAT_VERSION=${TOMCAT_MAJOR_VERSION}.${TOMCAT_MINOR_VERSION}

# Install essential packages.
RUN apk update && \
    apk add wget \
            unzip \
            nss \
            openjdk11-jre

# Create the default user/group to execute Apache Tomcat.
RUN addgroup -S group && \
    adduser -S user -G group

# Download Apache Tomcat and install it.
RUN cd /opt && \
    wget http://ftp.unicamp.br/pub/apache/tomcat/tomcat-${TOMCAT_MAJOR_VERSION}/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.zip && \
    unzip apache-tomcat-${TOMCAT_VERSION}.zip && \
    rm -rf /opt/apache-tomcat-${TOMCAT_VERSION}/bin/*.txt && \
    rm -rf /opt/apache-tomcat-${TOMCAT_VERSION}/bin/*.md && \
    rm -rf /opt/apache-tomcat-${TOMCAT_VERSION}/bin/LICENSE && \
    rm -rf /opt/apache-tomcat-${TOMCAT_VERSION}/bin/NOTICE && \
    rm -rf /opt/apache-tomcat-${TOMCAT_VERSION}/bin/RELEASE-NOTES && \
    rm -rf /opt/apache-tomcat-${TOMCAT_VERSION}/webapps/* && \
    rm apache-tomcat-${TOMCAT_VERSION}.zip && \
    chmod +x /opt/apache-tomcat-${TOMCAT_VERSION}/bin/*.sh && \
    ln -s /opt/apache-tomcat-${TOMCAT_VERSION} /opt/apache-tomcat

# Copy the application binary to Apache Tomcat.
COPY build/libs/demo-*.war /opt/apache-tomcat/webapps/demo.war

# Set the essentials permissions.
RUN chown -R user:group /opt/apache-tomcat-${TOMCAT_VERSION} && \
    chmod +x /opt/apache-tomcat/bin/*.sh

# Set the default user
USER user

# Set the default port
EXPOSE 8080

# Set the startup script and parameters.
ENTRYPOINT ["/opt/apache-tomcat/bin/catalina.sh"]
CMD ["jpda", "run"]