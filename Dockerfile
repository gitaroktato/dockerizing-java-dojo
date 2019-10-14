FROM openjdk:12-alpine
ARG JAR_FILE=demo-0.0.2-SNAPSHOT.jar
ENV JAR_FILE=${JAR_FILE}

WORKDIR /usr/demo
COPY ./target/$JAR_FILE ./

EXPOSE 8080

ENTRYPOINT ["sh", "-c"]
CMD ["java -jar $JAR_FILE"]
