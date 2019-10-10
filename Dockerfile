FROM openjdk:12-alpine

WORKDIR /usr/demo
COPY ./target/demo-0.0.1-SNAPSHOT.jar ./

EXPOSE 8080

ENTRYPOINT ["java"]
CMD ["-jar", "-Xms950m", "-Xmx950m", "demo-0.0.1-SNAPSHOT.jar"]
