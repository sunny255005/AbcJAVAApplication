FROM openjdk:11  as builder

WORKDIR /app-builder
COPY . /app-builder


ARG USE_BUILD_CONTAINER=1
#RUN if [ "$USE_BUILD_CONTAINER" = "1" ]; then /app-builder/gradlew clean build dependencyReport --stacktrace --warning-mode=fail; fi
RUN if [ "$USE_BUILD_CONTAINER" = "1" ]; then /app-builder/gradlew clean build dependencyReport --stacktrace; fi




USER appuser
WORKDIR /app

COPY --from=builder /app-builder/build/libs/*.jar /app/app.jar

CMD [ "java", "-jar", "app.jar" ]



# RUN javac FirstJava.java  
# CMD ["java", "FirstJava"]  
