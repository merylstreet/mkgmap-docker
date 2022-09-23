#!/bin/bash

file_name=poland-latest.osm.pbf
days_old=14 #how old can be file before we will re-download it

#echo "seconds_old $seconds_old"
#echo "now         $now"
#echo "file_old    $file_old"
#echo "difference  $difference"

if [[ -e $file_name ]]; then
	#jezeli plik istniej to sprawdzamy jak jest stary
	let "seconds_old=$days_old * 24 * 3600" #days_old but in SECONDS
	now=$(date +%s) #SECONDS since epoch
	file_old=$(date -r $file_name +%s) # file age in SECONDS from epoch
	let "difference=$now - $file_old"

	#jezeli jest starszy niz days_old to go sciagamy ponownie
	if [[ $secondsOld -gt $difference ]]; then
		echo "file $file_name is older than $days_old days -> download"
		DOWNLOAD=1
	else
		echo "file $file_name exists and is NOT older then $days_old days -> re-use it!"
	fi
else
	echo "file $file_name don't exist -> download"
	DOWNLOAD=1
fi

#rm -rf ./*pbf
#curl -LO https://download.geofabrik.de/europe/poland-latest.osm.pbf
#
#
#docker run -it --rm -v $(pwd):/data \
#    -e MAX_HEAP_SIZE=18G \
#    -e FAMILY_NAME=PL \
#    -e DESCRIPTION="PL by Ludw" \
#    -e PRODUCT_VERSION="2209" \
#    -e ID=7709 \
#    -e STYLE=mkgmap \
#    -e TYP=opentopomap \
#    ludw/mkgmap
