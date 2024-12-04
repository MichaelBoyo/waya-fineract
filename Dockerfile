# Use a base image with Java and Gradle pre-installed
FROM gradle:8.10.2 AS build

# Set the working directory inside the container
WORKDIR /app

# Copy the Gradle project into the container
COPY . .

# Ensure gradlew has execute permissions
RUN chmod +x ./gradlew

# Run the specified Gradle command
RUN ./gradlew :fineract-provider:jibDockerBuild -x  test