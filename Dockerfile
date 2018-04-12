#FROM maven:3.5-jdk-8
FROM maven:3.5-jdk-8-alpine as build
RUN mkdir -p /deploy/application
VOLUME ["/deploy/application"]
WORKDIR /deploy/application
ADD . /deploy/application
EXPOSE 8080
ENTRYPOINT ["mvn","clean","package"]
