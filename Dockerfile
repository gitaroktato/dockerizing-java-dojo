FROM gradle:jdk11 as build

WORKDIR /home/gradle/project

COPY . .
RUN gradle bootJar

FROM openjdk:11.0.4
ARG IMAGE_NAME="demo-0.0.2-SNAPSHOT.jar"

COPY --from=build /home/gradle/project/build/libs/$IMAGE_NAME .
ENV IMAGE_NAME=$IMAGE_NAME

ENTRYPOINT ["bash", "-c"]
CMD ["java -jar /${IMAGE_NAME}"]