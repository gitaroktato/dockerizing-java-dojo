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
Introduce multistage build by adding gradle build

