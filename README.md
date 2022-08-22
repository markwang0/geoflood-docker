Docker image with a [GeoFlood](https://github.com/passaH2O/GeoFlood) software environment (Python libraries, GRASS GIS, and TauDEM).

Supports amd64 and arm64 CPUs. Intended for personal computers. For HPC see https://github.com/dhardestylewis/geoflood_docker.

## Pull a pre-built image from [Docker Hub](https://hub.docker.com/repository/docker/markwang0/geoflood)

```sh
$ docker pull markwang0/geoflood:latest
```

## Use included [`geoflood-docker-run.sh`](https://github.com/markwang0/geoflood-docker/blob/main/geoflood-docker-run.sh) to run commands

All paths are on the host (local) machine. GeoFlood must be cloned on your local machine. For example:
```sh

$ ./geoflood-docker-run.sh python3 geoflood_demo/GeoFlood/GeoNet/pygeonet_grass_py3.py
```
```sh
$ ./geoflood-docker-run.sh mpiexec -n 4 dinfdistdown \
    -ang geoflood_demo/OUTPUT/GIS/OnionCreek/OC1mTest_ang.tif \
    -fel geoflood_demo/OUTPUT/GIS/OnionCreek/OC1mTest_fel.tif \
    -slp geoflood_demo/OUTPUT/GIS/OnionCreek/OC1mTest_slp.tif \
    -src geoflood_demo/OUTPUT/GIS/OnionCreek/OC1mTest_path.tif \
    -dd geoflood_demo/OUTPUT/GIS/OnionCreek/OC1mTest_hand_GeoFlood.tif \
    -m ave v
```
```sh
$ ./geoflood-docker-run.sh python3 geoflood_demo/GeoFlood/GeoFlood/Forecast_Table.py \
    geoflood_demo/INPUT/NWM/OnionCreek/nwm.t00z.analysis_assim.channel_rt.tm01.conus.nc
```

## Build locally

```sh
$ docker build .
```

## Build multi-arch image and push

```sh
$ ./build.sh
```
