FROM maven:3.9.9-eclipse-temurin-21 AS build

WORKDIR /app

COPY pom.xml .
COPY src ./src

RUN mvn -B clean package dependency:copy-dependencies -DincludeScope=runtime -DoutputDirectory=target/dependency

FROM eclipse-temurin:21-jre

WORKDIR /app

COPY --from=build /app/target/globalsolution-1.0-SNAPSHOT.jar ./app.jar
COPY --from=build /app/target/dependency ./dependency

EXPOSE 10000

CMD ["sh", "-c", "java -cp 'app.jar:dependency/*' Main"]
