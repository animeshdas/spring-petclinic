FROM maven:3.5-jdk-8
#FROM zenika/alpine-maven

RUN mkdir -p /deploy/application

VOLUME ["/deploy/application"]

WORKDIR /deploy/application

ADD . /deploy/application

ENTRYPOINT ["mvn","clean","package"]