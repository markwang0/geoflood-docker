Docker image with a [GeoFlood](https://github.com/passaH2O/GeoFlood) software environment (Python libraries, GRASS GIS, and TauDEM).

Supports amd64 and arm64 CPUs. Intended for personal computers. For HPC see https://github.com/dhardestylewis/geoflood_docker.

## Pull a pre-built image from [Docker Hub](https://hub.docker.com/repository/docker/markwang0/geoflood)

```sh
$ docker pull markwang0/geoflood:latest
```

## Build locally

```sh
$ docker build .
```

## Build multi-arch image and push

```sh
$ sudo chmod +x build.sh
$ ./build.sh
```
