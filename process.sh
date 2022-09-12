#!/bin/sh
set -x

#strony kodowe
#https://www.mkgmap.org.uk/pipermail/mkgmap-dev/2020q2/031087.html


# -z tests if string length is zero
[ -z "$MAX_HEAP_SIZE" ] && MAX_HEAP_SIZE="10G"
[ -z "$DESCRIPTION" ] && DESCRIPTION="ludwiczek maps"
[ -z "$FAMILY_NAME" ] && FAMILY_NAME="ludwiczek_maps"
[ -z "$PRODUCT_VERSION" ] && PRODUCT_VERSION=2209

# contours or opentopomap
[ -z "$STYLE" ] && STYLE=opentopomap

# we can include TYP as .txt file, it will be compiled by mkgmap during execution
TYP_DIR=/garmin/typ
TYP_FILE=${STYLE}.txt

mkdir -p /work

#JAVACMD_OPTIONS=-Xmx10G /osmosis/bin/osmosis -v  --read-osm /data/moroccoSRTM.osm --read-pbf /data/morocco-latest.osm.pbf --merge --sort --write-pbf /data/merged.pbf 

cd /work

java -Xmx${MAX_HEAP_SIZE} -jar /splitter/splitter.jar --output-dir=/work /data/*pbf

[ $? -eq 0] && java -Xmx${MAX_HEAP_SIZE} -jar /mkgmap/mkgmap.jar --mapname=63240901 \
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
    --precomp-sea=/sea-latest.zip \
    --gmapi \
    --dem=/data/dem/dem1/, /data/dem/dem3/ \
    --dem-dists=3312,13248,26512,53024 \
    --style-file=/garmin/style/${STYLE} \
    *.osm.pbf \
    ${TYP_DIR}/${TYP_FILE}

if [ $? -eq 0 ]; then
    mv gmapsupp.img /data/${FAMILY_NAME}.img
    mv -r ${FAMILY_NAME}.gmap /data/
fi

cd /