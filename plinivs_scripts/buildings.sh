#!/bin/bash

###############
# GRASS SETUP #
###############

# path to GRASS binaries and libraries:
export GISBASE=/usr/lib/grass74
export PATH=$PATH:$GISBASE/bin:$GISBASE/scripts
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$GISBASE/lib

# set PYTHONPATH to include the GRASS Python lib
if [ ! "$PYTHONPATH" ] ; then
   PYTHONPATH="$GISBASE/etc/python"
else
   PYTHONPATH="$GISBASE/etc/python:$PYTHONPATH"
fi
export PYTHONPATH

# use process ID (PID) as lock file number:
export GIS_LOCK=$$

# settings for graphical output to PNG file (optional)
export GRASS_PNGFILE=/tmp/grass6output.png
export GRASS_TRUECOLOR=TRUE
export GRASS_WIDTH=900
export GRASS_HEIGHT=1200
export GRASS_PNG_COMPRESSION=1
export GRASS_MESSAGE_FORMAT=plain

# path to GRASS settings file
export GISRC=$HOME/.grassrc7

# path to GRASS settings file
export GISRC=/tmp/grass7-${USER}-$GIS_LOCK/gisrc
# remove any leftover files/folder
rm -fr /tmp/grass7-${USER}-$GIS_LOCK
mkdir /tmp/grass7-${USER}-$GIS_LOCK
export TMPDIR="/tmp/grass7-${USER}-$GIS_LOCK"
# set GISDBASE, LOCATION_NAME, and/or MAPSET
echo "GISDBASE: /home/mario.nunez/script/grass" >>$GISRC
echo "LOCATION_NAME: location" >>$GISRC
echo "MAPSET: PERMANENT" >>$GISRC
# start in text mode
echo "GRASS_GUI: text" >>$GISRC


###########################
# BUILDINGS SCRIPT START #
###########################

LAYER=7
DATA="IT003L3_NAPOLI_UA2012_layers9_12"

#PARAMETERS
ALBEDO=`grep -i -F [$LAYER] parameters/albedo.dat | cut -f 2 -d ' '`
EMISSIVITY=`grep -i -F [$LAYER] parameters/emissivity.dat | cut -f 2 -d ' '`
TRANSMISSIVITY=`grep -i -F [$LAYER] parameters/transmissivity.dat | cut -f 2 -d ' '`
VEGETATION_SHADOW=`grep -i -F [$LAYER] parameters/vegetation_shadow.dat | cut -f 2 -d ' '`
RUNOFF_COEFFICIENT=`grep -i -F [$LAYER] parameters/run_off_coefficient.dat | cut -f 2 -d ' '`

#ESM RASTER
FILE="data/N20E46/class_50/200km_10m_N20E46_class50.TIF"
#FILE=$1
NAME=`echo $FILE | rev | cut -f 1 -d '/' | rev | cut -f 1 -d '.'`

#raster reclassification with treshold 25
TIF=$NAME"_calculated.TIF"
SHP=$NAME"_calculated.shp"
NODATA=`gdalinfo $FILE | grep 'NoData' | cut -f 2 -d '='`
python gdal_reclassify.py $FILE $TIF -r "$NODATA,1" -c "<45,>=45" -d $NODATA -n true -p "COMPRESS=LZW"

#raster parameters needed for polygonization
LAT=`gdalinfo $TIF | grep 'latitude_of_center' | cut -f 2 -d ',' | cut -f 1 -d ']'`
LON=`gdalinfo $TIF | grep 'longitude_of_center' | cut -f 2 -d ',' | cut -f 1 -d ']'`
X=`gdalinfo $TIF | grep 'false_easting' | cut -f 2 -d ',' | cut -f 1 -d ']'`
Y=`gdalinfo $TIF | grep 'false_northing' | cut -f 2 -d ',' | cut -f 1 -d ']'`
N=`gdalinfo $TIF | grep 'Upper Left' | cut -f 6 -d ' ' | cut -f 1 -d ')'`
S=`gdalinfo $TIF | grep 'Lower Right' | cut -f 5 -d ' ' | cut -f 1 -d ')'`
E=`gdalinfo $TIF | grep 'Lower Right' | cut -f 4 -d ' ' | cut -f 1 -d ','`
W=`gdalinfo $TIF | grep 'Upper Left' | cut -f 5 -d ' ' | cut -f 1 -d ','`
RES=`gdalinfo $TIF | grep 'Pixel Size' | cut -f 4 -d ' ' | cut -f 1 -d ',' | cut -f 2 -d '('`

#poligonization with grass
g.proj -c proj4="+proj=laea +lat_0=$LAT +lon_0=$LON +x_0=$X +y_0=$Y +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs"
r.external input="$TIF" band=1 output=rast_5bd8903d0a6372 --overwrite -o
g.region n=$N s=$S e=$E w=$W res=$RES
r.to.vect input=rast_5bd8903d0a6372 type="area" column="value" output=output08aad7e15cf0402da3436e32ac40c6c9 --overwrite
v.out.ogr type="auto" input="output08aad7e15cf0402da3436e32ac40c6c9" output="$SHP" format="ESRI_Shapefile" --overwrite

#result to databse
shp2pgsql -k -s 3035 -S -I -d $SHP $NAME > $NAME.sql
psql -d clarity -U postgres -f $NAME.sql
rm $NAME"_calculated.*"

#REMOVE INTERSECTIONS WITH LAYERS 6,5,4,3,2,1 check in postgis...
psql -U "postgres" -d "clarity" -c "DELETE FROM public.\""$NAME"\" WHERE gid IN (SELECT b.gid FROM public.\""$NAME"\" b, "$DATA"_water x WHERE ST_Intersects( b.geom , x.geom ) IS TRUE);"
psql -U "postgres" -d "clarity" -c "DELETE FROM public.\""$NAME"\" WHERE gid IN (SELECT b.gid FROM public.\""$NAME"\" b, "$DATA"_roads x WHERE ST_Intersects( b.geom , x.geom ) IS TRUE);"
psql -U "postgres" -d "clarity" -c "DELETE FROM public.\""$NAME"\" WHERE gid IN (SELECT b.gid FROM public.\""$NAME"\" b, "$DATA"_railways x WHERE ST_Intersects( b.geom , x.geom ) IS TRUE);"
psql -U "postgres" -d "clarity" -c "DELETE FROM public.\""$NAME"\" WHERE gid IN (SELECT b.gid FROM public.\""$NAME"\" b, "$DATA"_trees x WHERE ST_Intersects( b.geom , x.geom ) IS TRUE);"
psql -U "postgres" -d "clarity" -c "DELETE FROM public.\""$NAME"\" WHERE gid IN (SELECT b.gid FROM public.\""$NAME"\" b, "$DATA"_vegetation x WHERE ST_Intersects( b.geom , x.geom ) IS TRUE);"
psql -U "postgres" -d "clarity" -c "DELETE FROM public.\""$NAME"\" WHERE gid IN (SELECT b.gid FROM public.\""$NAME"\" b, "$DATA"_agricultural_areas x WHERE ST_Intersects( b.geom , x.geom ) IS TRUE);"

#drop not needed columns
psql -U "postgres" -d "clarity" -c "ALTER TABLE public.\""$NAME"\" DROP COLUMN cat;"
psql -U "postgres" -d "clarity" -c "ALTER TABLE public.\""$NAME"\" DROP COLUMN value;"
psql -U "postgres" -d "clarity" -c "ALTER TABLE public.\""$NAME"\" DROP COLUMN label;"

#add rest of the parameters to the layer
psql -U "postgres" -d "clarity" -c "ALTER TABLE public.\""$NAME"\" ADD albedo real DEFAULT "$ALBEDO";"
psql -U "postgres" -d "clarity" -c "ALTER TABLE public.\""$NAME"\" ADD emissivity real DEFAULT "$EMISSIVITY";"
psql -U "postgres" -d "clarity" -c "ALTER TABLE public.\""$NAME"\" ADD transmissivity real DEFAULT "$TRANSMISSIVITY";"
psql -U "postgres" -d "clarity" -c "ALTER TABLE public.\""$NAME"\" ADD vegetation_shadow real DEFAULT "$VEGETATION_SHADOW";"
psql -U "postgres" -d "clarity" -c "ALTER TABLE public.\""$NAME"\" ADD run_off_coefficient real DEFAULT "$RUNOFF_COEFFICIENT";"
#building shadow 1 por defecto(no interseccion) y actualizar a valor 0 cuando haya interseccion
psql -U "postgres" -d "clarity" -c "ALTER TABLE public.\""$NAME"\" ADD building_shadow smallint DEFAULT 1;"
psql -U "postgres" -d "clarity" -c "UPDATE public.\""$NAME"\" SET building_shadow=0 FROM (SELECT w.gid FROM public.\""$NAME"\" w, "$DATA"_layers9_12 b WHERE ST_Intersects( w.geom , b.geom ) IS TRUE GROUP BY w.gid) AS subquery WHERE public.\""$NAME"\".gid=subquery.gid;"

#FALTA VOLCAR SOBRE TABLA ROADS GLOBAL Y BORRAR LA TABLA ROADS DEL SHAPEFILE ACTUAL(ITALIA-NAPOLES)
##psql -U "postgres" -d "clarity" -c "INSERT INTO buildings (SELECT NEXTVAL('buildings_gid_seq'), area, perimeter, geom, albedo, emissivity, transmissivity, vegetation_shadow, run_off_coefficient, building_shadow FROM public.\""$NAME"\");"
##psql -U "postgres" -d "clarity" -c "DROP TABLE public.\""$NAME"\";"
