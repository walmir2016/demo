# Getting Started

This is a demo project for education/training purposes of DevOps.
It contains a pipeline that contains the following phases:

### 1. Compile and White Box Testing (SAST - Static Application Security Testing)
It uses:
- [Gradle](https://www.gradle.org) for project automation (Compile and orchestration of the execution of the code analysis).
- [Sonarcloud](https://sonarcloud.io) and [SNYK](https://snyk.io) for SAST.

### 2. Packaging
It uses:
- [Docker](https://www.docker.com) to encapsulate the application in a container and run in [Kubernetes](https://kubernetes.io) or [Docker Swarm](https://docs.docker.com/engine/swarm) clusters.

### 3. Publishing
It uses:
- [GitHub Packages](https://github.com/features/packages) to store the versions of the container image.

### 4. Deploy
It Used:
- [Linode](https://www.linode.com) as Cloud infrastructure that runs the [Kubernetes](https://kubernetes.io) cluster.
- [kubectl] as command line tool to orchestrate the deployments of the containers in the [Kubernetes](https://kubernetes.io) cluster.

### 5. Black Box Testing (DAST - Dynamic Application Security Testing / RASP - Runtime Application Self Protection)
- [Contrast Security](https://www.contrastsecurity.com) injecting an agent to capture/block the vulnerabilities from a scanner.
- [Probely](https://probely.com) as vulnerability scanner.

If any phases got errors or violations, the pipeline stops.

# Roadmap
- Add integration with Slack for notifications.
- Add integration with GitHub for ticket control.

# Architecture
The application was developed using Java, Spring, H2 Database and Docker. Check the documentation below.

# Reference Documentation
For further reference, please consider the following sections:

- [Official Gradle documentation](https://docs.gradle.org)
- [Spring Boot Gradle Plugin Reference Guide](https://docs.spring.io/spring-boot/docs/2.4.4/gradle-plugin/reference/html/)
- [Spring Web](https://docs.spring.io/spring-boot/docs/2.4.4/reference/htmlsingle/#boot-features-developing-web-applications)
- [Spring Data JPA](https://docs.spring.io/spring-boot/docs/2.4.4/reference/htmlsingle/#boot-features-jpa-and-spring-data)

### Guides
The following guides illustrate how to use some features concretely:

- [Serving Web Content with Spring MVC](https://spring.io/guides/gs/serving-web-content/)
- [Accessing Data with JPA](https://spring.io/guides/gs/accessing-data-jpa/)

### Additional Links
These additional references should also help you:

- [Gradle Build Scans – insights for your project's build](https://scans.gradle.com#gradle)
