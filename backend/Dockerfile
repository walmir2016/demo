# Define the base linux distribution.
FROM alpine:latest

# Define the maintainer of the project.
LABEL maintainer="fvilarinho@gmail.com"

# Install essential packages.
RUN apk update && \
    apk add bash \
            curl \
            wget \
            zip \
            unzip \
            vim \
            nss \
            openjdk11-jre \
            mariadb-client

# Create the default user/group and structure to execute Apache Tomcat.
RUN addgroup -S group && \
    adduser -S user -G group && \
    mkdir /home/user/lib && \
    mkdir /home/user/bin

# Copy the essentials files to the work directory.
COPY bin/startup.sh /home/user/bin
COPY build/libs/backend-latest.war /home/user/lib/demo.war

# Set the essentials permissions.
RUN chown -R user:group /home/user && \
    chmod -R o-rwx /home/user && \
    chmod u+x /home/user/bin/*.sh && \
    ln -s /home/user/bin/startup.sh /entrypoint.sh

# Set the default user.
USER user

# Set default work directory.
WORKDIR /home/user

# Set the default ports.
EXPOSE 8080 8000

# Boot script.
ENTRYPOINT ["/entrypoint.sh"]