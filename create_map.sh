#!/bin/bash

docker run -it --rm -v $(pwd):/data \
    -e MAX_HEAP_SIZE=14G \
    -e FAMILY_NAME=Poland \
    -e DESCRIPTION="PL by Ludw" \
    -e PRODUCT_VERSION="2209" \
    -e MAP_NAME=63240903 \
    -e STYLE=mkgmap \
    -e TYP=mkgmap \
    ludw/mkgmap
