USAGE:

- build docker image by running ```cd docker``` & ```./build.sh```
- download additional file by running ```cd garmin``` & ```./update.sh```
- allow executing with ```chmod +x create_paca.sh```
- run ```create_paca.sh``` (or create another one)

CONFIG:
- read the ```garmin.sh``` - it is the main workhorse.
- download OSM PBF data from <https://download.geofabrik.de/index.html>. You can download more than one *.pbf file - it will be complied into one output file

TODO:

- how to create files for Basecamp? --> --gmapi option for mkgmap
- how to add custom TYP file (opentopomap) -> include in the command line as last argument
- how to add height infomation (shape files)
- TYP file? <https://www.pinns.co.uk/osm/typwiz7.html>

TIPS:

- /Users/ludw/Library/Caches/com.garmin.BaseCamp -> delete TileCache

WEB RESOURCES:

- [gpx studio](https://gpx.studio/)
- <https://www.cferrero.net/maps/guide_to_mkgmap_style_files.html>
- <https://github.com/ligfietser/mkgmap-style-sheets>
