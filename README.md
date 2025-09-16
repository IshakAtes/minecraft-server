# Minecraft Server – Dockerized

## Table of Contents
- [Description](#description)
- [Quickstart](#quickstart)
- [Usage](#usage)
- [Testing](#testing)
- [Security Notes](#security-notes)

---

## Description
This repository contains everything needed to run a **self-hosted Minecraft server** in Docker.  
It includes:
- A custom `Dockerfile` (Java-based, no prebuilt images)
- A `docker-compose.yaml` for configuration and persistence
- A `.gitignore` to keep the repo clean
- Documentation in this `README.md`

Purpose:  
To provide a reproducible, configurable, and persistent Minecraft server setup using containers.

---

## Quickstart
### Requirements
- Docker & Docker Compose installed
- At least 2 GB RAM available
- Internet connection (for downloading the server JAR)

### Run the Server
```bash
git clone <this-repo>
cd minecraft-server
docker-compose up --build
