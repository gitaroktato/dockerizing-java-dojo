FROM openjdk:11.0.4
COPY build/libs/demo-0.0.1-SNAPSHOT.jar .
ENTRYPOINT ["java", "-jar"]
CMD ["/demo-0.0.1-SNAPSHOT.jar"]