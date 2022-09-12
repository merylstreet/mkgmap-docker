fork from <https://github.com/devshred/mkgmap-docker>

- build docker image by running ```./build.sh```
- read the ```process.sh``` - it is the main workhorse
- download OSM PBF data from <https://download.geofabrik.de/index.html>. You can download more than one *.pdf file - it will be complied into one output file
- run ```docker run --rm -it -v $(pwd):/data -e DESCRIPTION="map by ludw" ludw/mkgmap```

TODO:

- how to create files for Basecamp? --> --gmapi option for mkgmap
- how to add custom TYP file (opentopomap) -> include in the command line as last argument
- how to add height infomation (shape files)
- TYP file? <https://www.pinns.co.uk/osm/typwiz7.html>

TIPS:
/Users/ludw/Library/Caches/com.garmin.BaseCamp -> delete TileCache
