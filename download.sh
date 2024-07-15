#!/bin/bash

#Shinto Roose

module load gdal
module load cdo

cat <<EOL > sample.hdr
ENVI
samples = 8192
lines = 4096
bands = 1
header offset = 0
file type = ENVI Standard
data type = 2
interleave = bsq
byte order = 1
EOL

for dd in {1..9} ; do 

#wget https://noaadata.apps.nsidc.org/NOAA/G02158/unmasked/2017/05_May/SNODAS_unmasked_2017050${dd}.tar



tar -xvf SNODAS_unmasked_2017050${dd}.tar
gunzip *.gz

cp sample.hdr zz_ssmv11036tS__T0001TTNATS2017050${dd}05HP001.hdr

gdal_translate -of NetCDF -a_srs '+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs' -a_nodata -9999 -a_ullr -130.51666666666667 58.23333333333333 -62.25000000000000 24.10000000000000 zz_ssmv11036tS__T0001TTNATS2017050${dd}05HP001.dat SD_zz_ssmv11036tS__T0001TTNATS2017050${dd}05HP001.nc

cdo remapbil,/home/sroose/projects/ctb-sushama/sroose/storage_model/Output/DYN_FLD_EXP_2017_CTL_d/X/Samples-netcdf/DYN_FLD_EXP_2017_CTL_d_SD_201705.nc SD_zz_ssmv11036tS__T0001TTNATS2017050${dd}05HP001.nc Model_domain_SD_2017050${dd}.nc

rm zz_*


done
