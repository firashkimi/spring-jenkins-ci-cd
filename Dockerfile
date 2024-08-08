FROM maven:3.9.0-eclipse-temurin-17 AS build
WORKDIR /app
COPY . .
RUN mvn clean install

FROM amazoncorretto:17-alpine
WORKDIR /app
COPY --from=build /app/target/devops-ci-cd.jar /app/
EXPOSE 8082
CMD ["java", "-jar","devops-ci-cd.jar"]