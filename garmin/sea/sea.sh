#!/bin/bash
set +x

if ! [ -f sea-latest.zip ]; then
    curl -LO http://osm.thkukuk.de/data/sea-latest.zip
fi