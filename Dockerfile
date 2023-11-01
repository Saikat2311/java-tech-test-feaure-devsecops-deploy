FROM registry.access.redhat.com/ubi9/openjdk-17-runtime

USER root

RUN microdnf --setopt=install_weak_deps=0 --setopt=tsflags=nodocs install tar wget gzip -y

USER 185

RUN curl https://repo1.maven.org/maven2/org/apache/maven/apache-maven/3.8.6/apache-maven-3.8.6-bin.tar.gz -o /opt/apache-maven-3.8.6-bin.tar.gz 

RUN cd /opt/ && tar -xvf apache-maven-3.8.6-bin.tar.gz

COPY src /app/
COPY pom.xml /app/

WORKDIR /app

CMD ["/opt/apache-maven-3.8.6/bin/mvn", "clean","spring-boot:run", "-e"]

EXPOSE 8080