## Full GeoFlood workflow example using Docker
This GeoFlood workflow shows all steps necessary to create an inundation map on an example watershed. Only the commands are pasted below. For an explanation of each step see the original [Google Colab notebook](https://colab.research.google.com/github/passaH2O/notebooks/blob/main/GeoFlood_demo.ipynb) they are taken from. See the [GeoFlood software repository](https://github.com/passaH2O/GeoFlood), [training material](https://sites.google.com/site/passalacquagroup/tools-and-data), or publications for more information.

Publications:
 - [Zheng et al. 2018](https://doi.org/10.1029/2018WR023457)
 - [Passalacqua et al. 2010](https://doi.org/10.1029/2009JF001254)
 - [Sangireddy et al. 2016](https://doi.org/10.1016/j.jhydrol.2016.02.051)

Requirements: Docker, `git` & `wget`. Only tested with Linux and macOS.

Note: after finishing all steps in this example the `geoflood_demo` directory will be ~1.5 GB.





## Pull Docker image and shell script wrapper
```sh
mkdir geoflood_demo && cd geoflood_demo # working directory
docker pull markwang0/geoflood:latest
wget https://raw.githubusercontent.com/markwang0/geoflood-docker/main/geoflood-docker-run.sh
chmod +x geoflood-docker-run.sh
```
## Download and extract example input data
```sh
wget https://github.com/passaH2O/notebooks/raw/main/INPUT.tar.gz
tar xzvf INPUT.tar.gz
```
## Clone GeoFlood repo
```sh
git clone https://github.com/passaH2O/GeoFlood
```
## Run GeoFlood commands
Note: relative paths must be used when working with the provided shell script wrapper. This is due to the way the host filesystem is mounted within the Docker container.


```sh
./geoflood-docker-run.sh python3 \
    ./GeoFlood/GeoNet/pygeonet_configure.py \
    -dir . -p OnionCreek -n OC1mTest --no_chunk \
    --input_dir INPUT --output_dir OUTPUT
```
```sh
./geoflood-docker-run.sh python3 \
    ./GeoFlood/GeoNet/pygeonet_nonlinear_filter.py
```
```sh
./geoflood-docker-run.sh python3 \
    ./GeoFlood/GeoNet/pygeonet_grass_py3.py
```
```sh
./geoflood-docker-run.sh python3 \
    ./GeoFlood/GeoNet/pygeonet_slope_curvature.py
```
```sh
./geoflood-docker-run.sh python3 \
    ./GeoFlood/GeoNet/pygeonet_skeleton_definition.py
```
```sh
./geoflood-docker-run.sh python3 \
    ./GeoFlood/GeoFlood/Network_Node_Reading.py
```
```sh
./geoflood-docker-run.sh python3 \
    ./GeoFlood/GeoFlood/Relative_Height_Estimation.py
```
```sh
./geoflood-docker-run.sh python3 \
    ./GeoFlood/GeoFlood/Network_Extraction.py
```
```sh
./geoflood-docker-run.sh mpiexec -n 4 pitremove \
    -z ./INPUT/GIS/OnionCreek/OC1mTest.tif \
    -fel ./OUTPUT/GIS/OnionCreek/OC1mTest_fel.tif
```
```sh
./geoflood-docker-run.sh mpiexec -n 4 dinfflowdir \
    -fel ./OUTPUT/GIS/OnionCreek/OC1mTest_fel.tif \
    -ang ./OUTPUT/GIS/OnionCreek/OC1mTest_ang.tif \
    -slp ./OUTPUT/GIS/OnionCreek/OC1mTest_slp.tif
```
```sh
./geoflood-docker-run.sh mpiexec -n 4 dinfdistdown \
    -ang ./OUTPUT/GIS/OnionCreek/OC1mTest_ang.tif \
    -fel ./OUTPUT/GIS/OnionCreek/OC1mTest_fel.tif \
    -slp ./OUTPUT/GIS/OnionCreek/OC1mTest_slp.tif \
    -src ./OUTPUT/GIS/OnionCreek/OC1mTest_path.tif \
    -dd ./OUTPUT/GIS/OnionCreek/OC1mTest_hand_GeoFlood.tif \
    -m ave v
```
```sh
./geoflood-docker-run.sh python3 \
    ./GeoFlood/GeoFlood/Streamline_Segmentation.py
```
```sh
./geoflood-docker-run.sh python3 \
    ./GeoFlood/GeoFlood/Grass_Delineation_py3.py
```
```sh
./geoflood-docker-run.sh python3 \
    ./GeoFlood/GeoFlood/River_Attribute_Estimation.py
```
```sh
./geoflood-docker-run.sh python3 \
    ./GeoFlood/GeoFlood/Network_Mapping.py
```
```sh
./geoflood-docker-run.sh mpiexec -n 4 catchhydrogeo \
    -hand ./OUTPUT/GIS/OnionCreek/OC1mTest_hand_GeoFlood.tif \
    -catch ./OUTPUT/GIS/OnionCreek/OC1mTest_segmentCatchment.tif \
    -catchlist ./OUTPUT/Hydraulics/OnionCreek/OC1mTest_River_Attribute.txt \
    -slp ./OUTPUT/GIS/OnionCreek/OC1mTest_slp.tif \
    -h ./INPUT/Hydraulics/OnionCreek/stage.txt \
    -table ./OUTPUT/Hydraulics/OnionCreek/hydroprop-basetable.csv
```
```sh
./geoflood-docker-run.sh python3 \
    ./GeoFlood/GeoFlood/Hydraulic_Property_Postprocess.py
```
Here we need to uncomment line 63 of ./GeoFlood/GeoFlood/Forecast_Table.py to override the netCDF file and impose a flowrate large enough to cause inundation. This is only done for demonstration purposes. Use a text editor to uncomment or run one of the below commands. Note the command is slightly different on Linux and macOS.

```sh
# if using linux, run the GNU sed command below
sed -i 's/#Qs\[i\] = 500/Qs\[i\] = 500/g' \
    ./GeoFlood/GeoFlood/Forecast_Table.py

# if using macOS, run the BSD sed command below
sed -i '' 's/#Qs\[i\] = 500/Qs\[i\] = 500/g' \
    ./GeoFlood/GeoFlood/Forecast_Table.py
```
```sh
./geoflood-docker-run.sh python3 \
    ./GeoFlood/GeoFlood/Forecast_Table.py \
    ./INPUT/NWM/OnionCreek/nwm.t00z.analysis_assim.channel_rt.tm01.conus.nc
```
```sh
./geoflood-docker-run.sh mpiexec -n 4 inunmap \
    -hand ./OUTPUT/GIS/OnionCreek/OC1mTest_hand_GeoFlood.tif \
    -catch ./OUTPUT/GIS/OnionCreek/OC1mTest_segmentCatchment.tif \
    -forecast ./OUTPUT/NWM/OnionCreek/nwm.t00z.analysis_assim.channel_rt.tm01.conus.nc \
    -mapfile ./OUTPUT/Inundation/OnionCreek/OC1mTest_NWM_inunmap.tif
```

Afterwards, output files such as `./OUTPUT/GIS/OnionCreek/OC1mTest_hand_GeoFlood.tif` (HAND raster) and `./OUTPUT/Inundation/OnionCreek/OC1mTest_NWM_inunmap.tif` (inundation map) can be inspected with a GIS.
