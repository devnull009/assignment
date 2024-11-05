# Requirements

## System requirements

Minimal: At least 4 GBs of memory and SWAP file.

Recommended: At least 8 GBs of memory and SWAP file.

User account with UID and GID of 1000 (usually the default).

Packages: Docker, Python (optional)

System configuration:

```sh
# /etc/sysctl.conf
vm.max_map_count=262144
```

**Note:** The development and testing is performed on Pop!_OS 22.04 LTS.

## Versioning

The whole demo environment relies on hard-coded versions to avoid instabilities and discrepancies. Thus, you will find a lot of versions for the Jenkins plugins, Docker images, etc.

## Logging and monitoring

**Note**: Both require access to `root` and Docker socket. Thus, the file permissions for `filebeat.yml` and `metricbeat.yml` must remain with root ownership and `go-w` permissions.

Be aware this is for demo purposes and usually these services are not run in such way. By default, Docker images uses `1000` user/group id.

In a real environment this will look differntly.

## Services

**Reminder**: Please be aware that such systems (ELK/Jenkins) are usually already provisioned in cluster mode and not working in single node instances. Also, Jenkins Pipelines comes directly from Git repositories.

The environment provides you (through a `docker-compose.yml` file) with logging, monitoring, and automation systems. The logging and monitoring is based on ELK stack. The automation system is based on Jenkins.

*For the demo purposes, credentials are either default or completely removed!*

**Important**: There are two services (Filebeat and Metricbeat) which runs as `root` to capture logs and metrics from the Docker running containers (because of default Docker installation approach). They run like this for the demo purposes only.

The Jenkins Pipeline exists in two different forms:
1. Jenkinsfile (ready to be published in Git repository) and;
2. Python code, automatically started and imported in the running Jenkins

## Endpoints

**Note:** Authentication is required for Elasticsearch and Kibana with credentials found in `.env` file.

Elasticsearch: https://localhost:9200

Kibana: http://localhost:5601

Jenkins: http://localhost:8080

# How to run

**Note:** The whole thing is automated (service start, job import, job build, Docker container creation, Bakery App run).

To start the environmment:
```sh
$ ./start.sh
```

To stop the environment:
```sh
$ ./stop.sh
```

To list what is running:
```sh
$ docker compose ps
```

If everything is running correctly, you will end up with all services in healthy state and available endpoints.

To find the logs in Kibana:

```
log.file.path : "/var/jenkins_home/jobs/Bakery-App/builds/1/log"
container.name:"bakery-app"
```
