#!/bin/bash

#script will create Poland map
#directory: PL.gmap -> move to you Basecamp map folder (on mac: Garmin Mac Manager, copy to that folder)
#PL.img -> move to your device

url=https://download.geofabrik.de/europe/poland-latest.osm.pbf
#file_url=https://download.geofabrik.de/europe/poland/dolnoslaskie-latest.osm.pbf

MAX_HEAP_SIZE=18G
FAMILY_NAME=Poland
DESCRIPTION="Poland by Ludw"
PRODUCT_VERSION="2303"
MAP_NAME=77090001
STYLE=mkgmap
TYP=opentopomap

source create_functions.sh
download_pbf
docker_run