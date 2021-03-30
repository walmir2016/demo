FROM alpine:latest

ARG TOMCAT_MAJOR_VERSION=9
ARG TOMCAT_MINOR_VERSION=0.44
ARG TOMCAT_VERSION=${TOMCAT_MAJOR_VERSION}.${TOMCAT_MINOR_VERSION}

RUN apk update && \
    apk add wget \
            unzip \
            nss \
            openjdk11-jre

RUN addgroup -S group && \
    adduser -S user -G group

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

COPY build/libs/demo-*.war /opt/apache-tomcat/webapps/demo.war

RUN chown -R user:group /opt/apache-tomcat-${TOMCAT_VERSION} && \
    chmod og+x /opt/apache-tomcat/bin/*.sh

USER user

EXPOSE 8080

ENTRYPOINT ["/opt/apache-tomcat/bin/catalina.sh"]

CMD ["jpda", "run"]