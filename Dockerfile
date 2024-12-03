FROM openjdk:17-jdk-alpine as corebanking 
#FROM openjdk:17-jdk-alpine

WORKDIR /app

COPY fineract-provider/build/libs/fineract-app-1.0.0.jar app.jar

#COPY fineract-provider/build/libs/*.jar app.jar

WORKDIR /app/fineract-pentaho
RUN wget -q https://s3.eu-west-3.amazonaws.com/waya-2.0-file-resources/others/fineract-pentaho-0.0.1-SNAPSHOT.tar
RUN tar -xvf fineract-pentaho-0.0.1-SNAPSHOT.tar

WORKDIR /app/libs
RUN apk add --no-cache fontconfig ttf-dejavu
RUN wget -q https://repo1.maven.org/maven2/mysql/mysql-connector-java/8.0.23/mysql-connector-java-8.0.23.jar
RUN wget -q https://repo1.maven.org/maven2/mysql/mysql-connector-java/5.1.42/mysql-connector-java-5.1.42.jar
RUN cp /app/fineract-pentaho/fineract-pentaho-0.0.1-SNAPSHOT/lib/* /app/libs/
RUN cp /app/fineract-pentaho/fineract-pentaho-0.0.1-SNAPSHOT/fineract-pentaho-0.0.1-SNAPSHOT-plain.jar /app/libs/fineract-pentaho-0.0.1-SNAPSHOT-plain.jar

WORKDIR /app

ENTRYPOINT ["java", "-Dloader.path=/app/libs/", "-jar", "/app/app.jar"]