#!/bin/bash

docker run -it --rm -v $(pwd):/data \
    -e MAX_HEAP_SIZE=14G \
    -e FAMILY_NAME=Africa \
    -e DESCRIPTION="Africa by Ludw" \
    -e PRODUCT_VERSION="2209" \
    -e MAP_NAME=63240902 \
    ludw/mkgmap
