Docker image with a [GeoFlood](https://github.com/passaH2O/GeoFlood) software environment (Python libraries, GRASS GIS, and TauDEM).

Supports amd64 and arm64 CPUs. Intended for personal computers. For HPC see https://github.com/dhardestylewis/geoflood_docker.

## Pull a pre-built image from [Docker Hub](https://hub.docker.com/repository/docker/markwang0/geoflood)

```sh
$ docker pull markwang0/geoflood:latest
```

## Use included [`geoflood-docker-run.sh`](https://github.com/markwang0/geoflood-docker/blob/main/geoflood-docker-run.sh) to run commands

All paths are on the host (local) machine. Relative paths should be used due to the way the host filesystem is mounted within the Docker container. GeoFlood must be cloned on your local machine. See this [full example workflow](https://github.com/markwang0/geoflood-docker/blob/main/example_workflow.md) or the example commands below:
```sh

$ ./geoflood-docker-run.sh python3 geoflood_demo/GeoFlood/GeoNet/pygeonet_grass_py3.py
```
```sh
$ ./geoflood-docker-run.sh mpiexec -n 4 pitremove \
    -z ./INPUT/GIS/OnionCreek/OC1mTest.tif \
    -fel ./OUTPUT/GIS/OnionCreek/OC1mTest_fel.tif
```

## Build locally

```sh
$ docker build .
```

## Build multi-arch image and push

```sh
$ ./build.sh
```
