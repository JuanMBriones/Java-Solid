FROM diamol/maven AS builder
WORKDIR /usr/src/output
COPY pom.xml .
RUN mvn dependency:resolve-plugins
RUN mvn dependency:go-offline

COPY . .
RUN mvn package

# app
FROM diamol/openjdk

WORKDIR /app
COPY --from=builder /usr/src/output/target/design_principles-0.1.0-SNAPSHOT-jar-with-dependencies.jar ./design_principles-0.1.0-SNAPSHOT.jar

ENTRYPOINT ["java", "-jar", "/app/design_principles-0.1.0-SNAPSHOT.jar"]
