ARG JAR_FILE=demo-0.0.2-SNAPSHOT.jar
FROM openjdk:11-jdk AS build
ARG JAR_FILE

WORKDIR /usr/demo

COPY . .
RUN ./mvnw package

FROM openjdk:12-alpine
ARG JAR_FILE
ENV JAR_FILE=${JAR_FILE}

WORKDIR /usr/demo
COPY --from=build /usr/demo/target/$JAR_FILE .

EXPOSE 8080

ENTRYPOINT ["sh", "-c"]
CMD ["java -jar $JAR_FILE"]
