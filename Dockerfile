FROM gradle:jdk11 as build

WORKDIR /home/gradle/project

COPY . .
RUN gradle bootJar

RUN jlink \
    --verbose \
    --add-modules \
        java.base,java.sql,java.naming,java.desktop,java.management,java.security.jgss,java.instrument \
    --compress 2 --strip-debug --no-header-files --no-man-pages \
    --output /opt/jdk-11-minimal

FROM debian:stretch-slim
ARG IMAGE_NAME="demo-0.0.2-SNAPSHOT.jar"

COPY --from=build /opt/jdk-11-minimal /opt/jdk-11-minimal
COPY --from=build /home/gradle/project/build/libs/$IMAGE_NAME .
ENV IMAGE_NAME=$IMAGE_NAME

ENTRYPOINT ["bash", "-c"]
CMD ["/opt/jdk-11-minimal/bin/java -jar /${IMAGE_NAME}"]