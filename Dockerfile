ARG JAR_FILE=demo-0.0.2-SNAPSHOT.jar
ARG JDK_PATH="/opt/jdk-11-minimal"

FROM openjdk:12-alpine AS build
ARG JDK_PATH
ENV JDK_PATH=$JDK_PATH

WORKDIR /usr/demo

COPY . .
RUN ./mvnw package
RUN jlink \
    --verbose \
    --add-modules \
        java.base,java.sql,java.naming,java.desktop,java.management,java.security.jgss,java.instrument \
    --compress 2 --strip-debug --no-header-files --no-man-pages \
    --output "$JDK_PATH"

FROM alpine:3.10
ARG JAR_FILE
ARG JDK_PATH

ENV JAR_FILE=${JAR_FILE}
ENV JDK_PATH=$JDK_PATH

WORKDIR /usr/demo

COPY --from=build $JDK_PATH $JDK_PATH
COPY --from=build /usr/demo/target/$JAR_FILE .

EXPOSE 8080

ENTRYPOINT ["sh", "-c"]
CMD ["/${JDK_PATH}/bin/java -jar ${JAR_FILE}"]
