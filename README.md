Docker image with a [GeoFlood](https://github.com/passaH2O/GeoFlood) software environment (Python libraries, GRASS GIS, and TauDEM).

Supports amd64 and arm64 CPUs. Intended for personal computers. For HPC see https://github.com/dhardestylewis/geoflood_docker.

## Pull a pre-built image from [Docker Hub](https://hub.docker.com/repository/docker/markwang0/geoflood)

```sh
$ docker pull markwang0/geoflood:latest
```

## Use included [`docker_run.sh`](https://github.com/markwang0/geoflood-docker/blob/main/docker_run.sh) to run commands

All paths are on the host (local) machine. GeoFlood must be cloned on your local machine. For example:

```sh
$ sudo chmod +x docker_run.sh
```
```sh
$ ./docker_run.sh python3 geoflood_demo/GeoFlood/GeoNet/pygeonet_grass_py3.py
```
```sh
$ ./docker_run.sh mpiexec -n 4 dinfdistdown \
    -ang geoflood_demo/OUTPUT/GIS/OnionCreek/OC1mTest_ang.tif \
    -fel geoflood_demo/OUTPUT/GIS/OnionCreek/OC1mTest_fel.tif \
    -slp geoflood_demo/OUTPUT/GIS/OnionCreek/OC1mTest_slp.tif \
    -src geoflood_demo/OUTPUT/GIS/OnionCreek/OC1mTest_path.tif \
    -dd geoflood_demo/OUTPUT/GIS/OnionCreek/OC1mTest_hand_GeoFlood.tif \
    -m ave v
```
```sh
$ ./docker_run.sh python3 geoflood_demo/GeoFlood/GeoFlood/Forecast_Table.py \
    geoflood_demo/INPUT/NWM/OnionCreek/nwm.t00z.analysis_assim.channel_rt.tm01.conus.nc
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
