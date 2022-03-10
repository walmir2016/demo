# Define the base linux distribution.
FROM alpine:latest

# Define the maintainer of the project.
LABEL maintainer="fvilarinho@gmail.com"

# Default environment variables.
ENV MYSQL_ROOT_PASSWORD=demo
ENV HOME_DIR=/home/user
ENV BIN_DIR=${HOME_DIR}/bin
ENV LIB_DIR=${HOME_DIR}/lib

# Install essential packages.
RUN apk update && \
    apk add bash \
            nss \
            openjdk11-jre

# Create the default user/group and structure to execute Apache Tomcat.
RUN addgroup -S group && \
    adduser -S user -G group && \
    mkdir -p ${LIB_DIR} ${BIN_DIR}

# Copy the essentials files to the work directory.
COPY bin/startup.sh ${BIN_DIR}
COPY build/libs/backend-*.war ${LIB_DIR}/demo.war

# Set the essentials permissions.
RUN chown -R user:group ${HOME_DIR} && \
    chmod -R o-rwx ${HOME_DIR} && \
    chmod u+x ${BIN_DIR}/*.sh && \
    ln -s ${BIN_DIR}/startup.sh /entrypoint.sh

# Set the default user.
USER user

# Set default work directory.
WORKDIR /home/user

# Set the default port.
EXPOSE 8080 8000

# Boot script.
ENTRYPOINT ["/entrypoint.sh"]