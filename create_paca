#!/bin/bash
set -x

url=https://download.geofabrik.de/europe/france/provence-alpes-cote-d-azur-latest.osm.pbf

MAX_HEAP_SIZE=2G
FAMILY_NAME=PACA
DESCRIPTION="PACA-custom"
PRODUCT_VERSION="2409"
MAP_NAME=77100001
STYLE=mkgmap
TYP=opentopomap

source create_functions.sh
download_pbf
docker_run
change_ownership
