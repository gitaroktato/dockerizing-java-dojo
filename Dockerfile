FROM openjdk:11.0.4
ARG IMAGE_NAME="demo-0.0.1-SNAPSHOT.jar"

COPY build/libs/$IMAGE_NAME .

ENTRYPOINT ["java", "-jar"]
CMD ["/${IMAGE_NAME}"]