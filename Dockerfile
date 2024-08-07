FROM amazoncorretto:17-alpine
COPY target/*.jar /opt/app/devops-ci-cd.jar
EXPOSE 8082
ENTRYPOINT ["java","-jar","/opt/app/devops-ci-cd.jar"]