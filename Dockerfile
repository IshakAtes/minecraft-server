# Use OpenJDK as base (Minecraft requires Java 17+)
FROM openjdk:21-jdk-slim

# 2. Setze das Arbeitsverzeichnis im Container
WORKDIR /app

COPY . $WORKDIR

# Automatically accept the EULA
RUN echo "eula=true" > eula.txt

# Default Environment Variablen (not Critical)
ENV MAX_MEMORY=${MAX_MEMORY:-2G} \
    MIN_MEMORY=${MIN_MEMORY:-1G} \
    MOTD=${MOTD:-"My Dockerized Minecraft Server"}

EXPOSE 25565

# Start the Minecraft server
CMD ["sh", "-c", "java -Xmx${MAX_MEMORY} -Xms${MIN_MEMORY} -jar server.jar nogui"]