# Dockerized Minecraft Server Setup & Testing with mcstatus

This project describes how to host a Minecraft server on a cloud VM using Docker Compose and how to test it using `mcstatus`.

---

## Table of Contents
- [Description](#description)
- [Quickstart](#quickstart)
- [Usage](#usage)
  - [Requirements](#requirements)
  - [Steps to Start a Dockerized Minecraft Server](#steps)
  - [Start and rebuild, important note](#notes)
- [Testing](#2-testing-the-server-with-mcstatus)
  - [Testing steps](#steps-1)
- [Data persistence](#data-persistence)

---

## Description

This repository contains everything needed to run a dedicated Minecraft server using Docker and Docker Compose.  
It includes:
- `Dockerfile` → builds a custom image with OpenJDK and the Minecraft server `.jar`
- `docker-compose.yaml` → defines the `mc-server` service, port mapping, environment variables, and volumes
- `.env` → environment variables for configuration (e.g., port, memory, MOTD, world name)
- `.gitignore` → prevents irrelevant files from being committed
- `README.md` → documentation (this file)

The goal is to have a **persistent, configurable, and portable Minecraft server**, which can be hosted in the cloud and tested programmatically.

---

## Quickstart
```bash
# 1. Clone repository
git clone https://github.com/IshakAtes/minecraft-server.git
cd minecraft-server

# 2. Create .env file
nano .env

# 3. Start server
docker compose up -d

# 4. Verify container is running
docker ps

# Your server will now be reachable under:
<CLOUD_VM_IP>:<SERVER_PORT>
```

---




## Usage

### Requirements
- Cloud VM with Docker and Docker Compose installed
- SSH access to the VM
- Minecraft server `.jar` file placed in the repository folder


### Steps
1. Clone the repository:
```bash
git clone https://github.com/IshakAtes/minecraft-server.git
cd minecraft-server
```

2. Create and configure the `.env` file:
``` bash
nano .env
```
> [!NOTE]
> The `.env` file controls server configuration. Example:
``` bash
# Port on which the server is reachable from the host
SERVER_PORT=5000

# Memory allocation
MAX_MEMORY=2G
MIN_MEMORY=1G

# Minecraft Server settings
MOTD=Welcome to my Dockerized Minecraft Server
MC_VERSION=1.20.1
MAX_PLAYERS=20

# Optional: set a custom level/world name
WORLD_NAME=mc_world
```


3. Start the Minecraft server:
``` bash
docker compose up -d --build
```


4. Check if the server is running:
``` bash
docker ps
```
- The minecraft-server container should appear in the list.

### Notes
> [!WARNING]
> If you change `environment variables` or the `Dockerfile`, start the container with `--build`. This ensures that Docker does not start using the old image, but instead creates a new image and starts the container with the new variables:
```bash
docker compose down
docker compose up -d --build
```
> [!NOTE]
> To clean up old, unused images:
``` bash
docker image prune -a
```


## 2. Testing the Server with mcstatus

### Steps
You can test the server using the [MC-Status](https://github.com/py-mine/mcstatus.git) Python tool.
``` bash
# 1. Clone mcstatus
git clone https://github.com/py-mine/mcstatus.git
cd mcstatus

# 2. Create and activate Python virtual environment
python -m venv venv
.\venv\Scripts\activate.ps1   # PowerShell

# 3. Install dependencies
pip install -r requirements.txt
# or:
pip install mcstatus

# 4. Check server status
mcstatus <CLOUD_VM_IP>:<EXAMPLE_PORT_5000> status

# Example output:
version: Java 1.21.8 (protocol 772)
motd: A Minecraft Server
players: 0/20 No players online
ping: 77.94 ms
```

> [!NOTE]
> Alternatively, connect with a Minecraft Java client using <CLOUD_VM_IP>:<EXAMPLE_PORT_5000>.


### Data persistence
The `./data` volume ensures that:
- worlds
- configurations
- progress
are not lost when containers are stopped or restarted.