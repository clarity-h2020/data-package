#!/bin/bash

LAYER=2
FILE="data/UA_IT003L3_NAPOLI/Shapefiles/IT003L3_NAPOLI_UA2012.shp"
#FILE=$1
SHP=`ogrinfo $FILE | grep '1:' | cut -f 2 -d ' '`
NAME=$SHP"_roads"

#PARAMETERS
ALBEDO=`grep -i -F [$LAYER] parameters/albedo.dat | cut -f 2 -d ' '`
EMISSIVITY=`grep -i -F [$LAYER] parameters/emissivity.dat | cut -f 2 -d ' '`
TRANSMISSIVITY=`grep -i -F [$LAYER] parameters/transmissivity.dat | cut -f 2 -d ' '`
VEGETATION_SHADOW=`grep -i -F [$LAYER] parameters/vegetation_shadow.dat | cut -f 2 -d ' '`
RUNOFF_COEFFICIENT=`grep -i -F [$LAYER] parameters/run_off_coefficient.dat | cut -f 2 -d ' '`

#ROADS (12210 Fast transit roads and associated land,12220 Other roads and associated land)
ogr2ogr -sql "SELECT area,perimeter,CODE2012 FROM "$SHP" WHERE CODE2012='12210' OR CODE2012='12220'" $NAME $FILE
shp2pgsql -k -s 3035 -S -I -d $NAME/$SHP.shp $NAME > $NAME".sql"
rm -r $NAME
psql -d clarity -U postgres -f $NAME".sql"
rm $NAME".sql"
#adding rest of parameters
psql -U "postgres" -d "clarity" -c "ALTER TABLE "$NAME" ADD albedo real DEFAULT "$ALBEDO";"
psql -U "postgres" -d "clarity" -c "ALTER TABLE "$NAME" ADD emissivity real DEFAULT "$EMISSIVITY";"
psql -U "postgres" -d "clarity" -c "ALTER TABLE "$NAME" ADD transmissivity real DEFAULT "$TRANSMISSIVITY";"
psql -U "postgres" -d "clarity" -c "ALTER TABLE "$NAME" ADD vegetation_shadow real DEFAULT "$VEGETATION_SHADOW";"
psql -U "postgres" -d "clarity" -c "ALTER TABLE "$NAME" ADD run_off_coefficient real DEFAULT "$RUNOFF_COEFFICIENT";"

#building shadow 1 by default(not intersecting) then update with value 0 when intersection occurs
psql -U "postgres" -d "clarity" -c "ALTER TABLE "$NAME" ADD building_shadow smallint DEFAULT 1;"
psql -U "postgres" -d "clarity" -c "UPDATE "$NAME" SET building_shadow=0 FROM (SELECT r.gid FROM "$NAME" r, "$SHP"_layers9_12 b WHERE ST_Intersects( r.geom , b.geom ) IS TRUE GROUP BY r.gid) AS subquery WHERE "$NAME".gid=subquery.gid;"

#hillshade_building 0 by default then update depending on intersections
psql -U "postgres" -d "clarity" -c "ALTER TABLE "$NAME" ADD hillshade_building real DEFAULT 0;"
#hillshade_building intersection with layer12(CODE2012=12100) assign 0.5
psql -U "postgres" -d "clarity" -c "UPDATE "$NAME" SET hillshade_building=0.5 FROM (SELECT r.gid FROM "$NAME" r, "$SHP"_layers9_12 b WHERE b.CODE2012='12100' AND ST_Intersects( r.geom , b.geom ) IS TRUE GROUP BY r.gid) AS subquery WHERE "$NAME".gid=subquery.gid;"
#hillshade_building intersection with layer11(CODE2012=11230,11240,11300) assign 0.5
psql -U "postgres" -d "clarity" -c "UPDATE "$NAME" SET hillshade_building=0.5 FROM (SELECT r.gid FROM "$NAME" r, "$SHP"_layers9_12 b WHERE (b.CODE2012='11230' OR b.CODE2012='11240' OR b.CODE2012='11300') AND ST_Intersects( r.geom , b.geom ) IS TRUE GROUP BY r.gid) AS subquery WHERE "$NAME".gid=subquery.gid;"
#hillshade_building intersection with layer10(CODE2012=11220) assign 0.8
psql -U "postgres" -d "clarity" -c "UPDATE "$NAME" SET hillshade_building=0.8 FROM (SELECT r.gid FROM "$NAME" r, "$SHP"_layers9_12 b WHERE (b.CODE2012='11220') AND ST_Intersects( r.geom , b.geom ) IS TRUE GROUP BY r.gid) AS subquery WHERE "$NAME".gid=subquery.gid;"
#hillshade_building intersection with layer9(CODE2012=11210,11100) assign 1
psql -U "postgres" -d "clarity" -c "UPDATE "$NAME" SET hillshade_building=1 FROM (SELECT r.gid FROM "$NAME" r, "$SHP"_layers9_12 b WHERE (b.CODE2012='11210' OR b.CODE2012='11100') AND ST_Intersects( r.geom , b.geom ) IS TRUE GROUP BY r.gid) AS subquery WHERE "$NAME".gid=subquery.gid;"

#FALTA VOLCAR SOBRE TABLA ROADS GLOBAL Y BORRAR LA TABLA ROADS DEL SHAPEFILE ACTUAL(ITALIA-NAPOLES)
#psql -U "postgres" -d "clarity" -c "INSERT INTO roads(SELECT NEXTVAL('roads_gid_seq'), area, perimeter, code2012, geom, albedo, emissivity, transmissivity, vegetation_shadow, run_off_coedfficient, building_shadow, hillshade_building FROM "$NAME");"
#psql -U "postgres" -d "clarity" -c "DROP TABLE "$NAME";"
