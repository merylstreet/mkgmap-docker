#!/bin/sh
set -x

#strony kodowe
#https://www.mkgmap.org.uk/pipermail/mkgmap-dev/2020q2/031087.html


#docker run -v $(pwd):/data
GARMIN_DIR=/data/garmin
DEM_FILES=${GARMIN_DIR}/dem/dem1/,${GARMIN_DIR}/dem/dem3/
SEA_FILES=${GARMIN_DIR}/sea


# -z tests if string length is zero
[ -z "$MAX_HEAP_SIZE" ] && MAX_HEAP_SIZE="10G"
[ -z "$DESCRIPTION" ] && DESCRIPTION="ludwiczek maps"
[ -z "$FAMILY_NAME" ] && FAMILY_NAME="ludwiczek_maps"
[ -z "$PRODUCT_VERSION" ] && PRODUCT_VERSION=2209
[ -z "$MAP_NAME" ] && MAP_NAME=63240901

#style & typ
[ -z "$STYLE" ] && STYLE=opentopomap
[ -z "$TYP" ] && TYP=opentopomap

# we can include TYP as .txt file, it will be compiled by mkgmap during execution
TYP_DIR=${GARMIN_DIR}/typ
TYP_FILE=${TYP}.txt
STYLE_DIR=${GARMIN_DIR}/style

mkdir -p /work

#JAVACMD_OPTIONS=-Xmx10G /osmosis/bin/osmosis -v  --read-osm /data/moroccoSRTM.osm --read-pbf /data/morocco-latest.osm.pbf --merge --sort --write-pbf /data/merged.pbf 


cd /work

java -Xmx${MAX_HEAP_SIZE} -jar /splitter/splitter.jar --output-dir=/work /data/*pbf

[ $? -eq 0 ] && java -Xmx${MAX_HEAP_SIZE} -jar /mkgmap/mkgmap.jar --mapname=${MAP_NAME} \
    --name-tag-list=name:en,int_name,name:fr,name \
    --code-page=1252 \
    --description="${DESCRIPTION} ${PRODUCT_VERSION}" \
    --series-name="${DESCRIPTION} ${PRODUCT_VERSION}" \
    --family-name="${FAMILY_NAME}" \
    --product-version=$PRODUCT_VERSION \
    --gmapsupp \
    --route \
    --remove-short-arcs \
    --add-pois-to-areas \
    --precomp-sea=${SEA_FILES}/sea-latest.zip \
    --gmapi \
    --dem="${DEM_FILES}" \
    --dem-dists=3312,13248,26512,53024 \
    --style-file=${STYLE_DIR}/${STYLE} \
    *.osm.pbf \
    ${TYP_DIR}/${TYP_FILE}

if [ $? -eq 0 ]; then
    mv gmapsupp.img /data/${FAMILY_NAME}.img
    mv ${FAMILY_NAME}.gmap /data/
fi

cd /
