#!/bin/sh
set -x

[ -z "$MAX_HEAP_SIZE" ] && MAX_HEAP_SIZE="8G"
[ -z "$DESCRIPTION" ] && DESCRIPTION="ludw map"

mkdir -p /work

java -Xmx${MAX_HEAP_SIZE} -jar /splitter/splitter.jar --output-dir=/work /data/*.pbf

cd /work

java -Xmx${MAX_HEAP_SIZE} -jar /mkgmap/mkgmap.jar --mapname=63240901 --description="${DESCRIPTION}" --gmapsupp --route --remove-short-arcs --add-pois-to-areas *.osm.pbf

mv gmapsupp.img /data/gmapbmap.img

cd /
rm -rf /work