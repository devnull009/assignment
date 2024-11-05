#!/bin/bash

CWD=$(basename "$PWD")

# Stop all applications
docker compose down --remove-orphans --volumes --rmi "all"
docker kill bakery-app || true
docker rm bakery-app || true

# Manually remove created and pulled Docker images
docker image rm -f bakery-app:latest || true
docker image rm -f "$CWD-jenkins:latest" || true
docker image rm -f "$CWD-python:latest" || true

# Make prune
docker system prune -f || true

# Report which objects are left
echo "List of Docker containers:"
docker ps -a
echo
echo "List of Docker images:"
docker image ls
echo
echo "List of Docker volumes:"
docker volume ls
echo
echo "List of Docker networks:"
docker network ls
echo
