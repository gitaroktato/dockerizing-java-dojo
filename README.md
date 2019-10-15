# dockerizing-java-dojo
Coding Dojo example for dockerizing Java

# Step 0
Go to [start.spring.io](https://start.spring.io/) and generate a Spring Boot app.
It should return "Hello World" HTTP response on a REST API. 

# Step 1
Create a simple Dockerfile that starts your application.

## Step 1.2
Add docker-compose.yml

## Step 1.3
Decouple jar name with `ARG`

# Step 2
Introduce multistage build by adding gradle/maven build

# Step 2.1
Use .dockerignore

# Step 2.2
Reuse gradle/maven cache

# Step 3
Create custom JRE with `jlink`
Commands are the following:
```bash
jdeps -s ./build/libs/demo-0.0.2-SNAPSHOT.jar
```

```bash
jlink --module-path "%JAVA_HOME%\jmods";build\libs \
      --add-modules java.base,java.logging,java.sql,java.naming,java.desktop,java.security.jgss,java.management,java.instrument \
      --output jre
```

Hint: OpenJDK [Dockerfile](https://github.com/AdoptOpenJDK/openjdk-docker/blob/master/12/jdk/alpine/Dockerfile.hotspot.releases.slim)

# Step 4
Using jib for building the Docker image
```bash
gradlew jib -Dhttp.proxyPort=0 -Dhttps.proxyPort=0 --image=popnam/dockerizing-java-dojo
```

```bash
gradlew jibDockerBuild -Dhttp.proxyPort=0 -Dhttps.proxyPort=0 --image=dockerizing-java-dojo
```

```bash
mvn compile jib:dockerBuild
```

# Step 5
Using skaffold

```bash
eval $(minikube docker-env)
skaffold init
skaffold dev
```

Access minikube service
```bash
minikube service app --url
```