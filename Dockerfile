FROM openjdk:17
EXPOSE 8082
ADD target/devops-ci-cd.jar devops-ci-cd.jar
ENTRYPOINT ["java","-jar","/devops-ci-cd.jar"]