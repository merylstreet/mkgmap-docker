fork from <https://github.com/devshred/mkgmap-docker>

- build docker image by running ```./build.sh```
- download OSM PBF data from <https://download.geofabrik.de/index.html>. You can download more than one *.pdf file - it will be complied into one output file
- run ```docker run --rm -it -v $(pwd):/data -e DESCRIPTION="map by ludw" ludw/mkgmap```

TODO:

- how to create files for Basecamp?
- how to add custom TYP file (opentopomap)
- how to add height infomation (shape files)
