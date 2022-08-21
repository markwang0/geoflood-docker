Dockerfile for building a Docker image that can run each step of the [GeoFlood](https://github.com/passaH2O/GeoFlood) workflow, including GRASS GIS and TauDEM operations.

Supports amd64 (Intel) and arm64 (Apple silicon) CPU architectures. Docker will automatically provide the architecture that matches your system. This image is intended to be used on a personal computer. For an image that can be run in an HPC environment see https://github.com/dhardestylewis/geoflood_docker.

## Pull a pre-built image from [Docker Hub](https://hub.docker.com/repository/docker/markwang0/geoflood)
---
```sh
$ docker pull markwang0/geoflood:latest
```

## Build locally
---
```sh
$ docker build .
```

## Script to build multi-arch images and push to Docker Hub
---
```sh
$ sudo chmod +x build.sh
$ ./build.sh
```
