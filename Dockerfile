
FROM openjdk:17-jdk-alpine as stage1
WORKDIR /app
COPY gradle gradle
COPY src src
COPY build.gradle .
COPY gradlew .
COPY settings.gradle .
RUN chmod 777 gradlew
RUN ./gradlew bootJar
  
FROM openjdk:17-jdk-alpine
WORKDIR /app
COPY --from=stage1 /app/build/libs/*.jar app.jar
  
ENTRYPOINT ["java", "-jar", "app.jar"]