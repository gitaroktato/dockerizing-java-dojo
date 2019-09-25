From openjdk:11.0.4

WORKDIR /usr/demo

COPY ./target/demo-0.0.1-SNAPSHOT.jar ./

CMD ["java", "-jar", "demo-0.0.1-SNAPSHOT.jar"]