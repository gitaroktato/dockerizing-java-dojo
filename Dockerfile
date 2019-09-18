ARG IMAGE_NAME="demo-0.0.2-SNAPSHOT.jar"
ARG JDK_PATH="/opt/jdk-11-minimal"

FROM gradle:jdk11 as build
ARG JDK_PATH

ENV JDK_PATH=$JDK_PATH
WORKDIR /home/gradle/project

COPY . .
RUN gradle bootJar

RUN jlink \
    --verbose \
    --add-modules \
        java.base,java.sql,java.naming,java.desktop,java.management,java.security.jgss,java.instrument \
    --compress 2 --strip-debug --no-header-files --no-man-pages \
    --output "$JDK_PATH"

FROM debian:stretch-slim
ARG IMAGE_NAME
ARG JDK_PATH

ENV IMAGE_NAME=$IMAGE_NAME
ENV JDK_PATH=$JDK_PATH

COPY --from=build $JDK_PATH $JDK_PATH
COPY --from=build /home/gradle/project/build/libs/$IMAGE_NAME .

ENTRYPOINT ["bash", "-c"]
CMD ["/${JDK_PATH}/bin/java -jar /${IMAGE_NAME}"]