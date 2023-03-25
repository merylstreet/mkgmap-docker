#!/bin/bash
set -x

url=https://download.geofabrik.de/africa/canary-islands-latest.osm.pbf

MAX_HEAP_SIZE=18G
FAMILY_NAME=Canary
DESCRIPTION="Canary by Ludw"
PRODUCT_VERSION="2303"
MAP_NAME=77100001
STYLE=mkgmap
TYP=opentopomap

source create_functions.sh
download_pbf
docker_run