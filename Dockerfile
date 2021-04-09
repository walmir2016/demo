# Define the base linux distribution.
FROM alpine:latest

# Define the Apache Tomcat version to be used.
ARG TOMCAT_MAJOR_VERSION=9
ARG TOMCAT_MINOR_VERSION=0.45
ARG TOMCAT_VERSION=${TOMCAT_MAJOR_VERSION}.${TOMCAT_MINOR_VERSION}

# Install essential packages.
RUN apk update && \
    apk add bash \
            wget \
            unzip \
            nss \
            openjdk11-jre

# Create the default user/group and structure to execute Apache Tomcat.
RUN addgroup -S group && \
    adduser -S user -G group && \
    mkdir /home/user/lib && \
    mkdir /home/user/etc && \
    mkdir /home/user/bin && \
    mkdir -p etc/contrast/java

# Copy the essentials files to work directory.
COPY bin/startup.sh /home/user/bin
COPY etc/contrast_security.yaml /home/user/etc
COPY lib/contrast.jar /home/user/lib
COPY build/libs/demo-*.war /home/user/lib/demo.war

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
    ln -s /opt/apache-tomcat-${TOMCAT_VERSION} /opt/apache-tomcat && \
    ln -s /home/user/lib/demo.war /opt/apache-tomcat/webapps/demo.war && \
    ln -s /home/user/etc/contrast_security.yaml /etc/contrast/java/contrast_security.yaml

# Set the essentials permissions.
RUN chown -R user:group /opt/apache-tomcat-${TOMCAT_VERSION} && \
    chown -R user:group /home/user && \
    chmod -R o-rwx /opt/apache-tomcat-${TOMCAT_VERSION} && \
    chmod -R o-rwx /home/user && \
    chmod u+x /home/user/bin/*.sh && \
    chmod u+x /opt/apache-tomcat/bin/*.sh && \
    ln -s /home/user/bin/startup.sh /entrypoint.sh

# Set the default user.
USER user

# Set default work directory.
WORKDIR /home/user

# Set the default port.
EXPOSE 8080

# Set the startup script and parameters.
ENTRYPOINT ["/entrypoint.sh"]