days_old=14

download_pbf () {
	DOWNLOAD=

	# https://tldp.org/LDP/abs/html/string-manipulation.html
	# Substring removal -> ${url##*\/}
	local file_name=${url##*\/}

	if [[ -e $file_name ]]; then
		#jezeli plik istniej to sprawdzamy jak jest stary
		let oldest="$(date +%s) - ($days_old * 24 * 3600)"
		file_old=$(date -r $file_name +%s) # file age in SECONDS from epoch

		#jezeli plik jest starszy niż days_old to ściagamy go ponownie
		if [[ $oldest -gt $file_old ]]; then
			echo "file $file_name is older than $days_old days -> download"
			DOWNLOAD=1
		else
			echo "file $file_name exists and is NOT older then $days_old days -> re-use it!"
		fi
	else
		echo "file $file_name don't exist -> download"
		DOWNLOAD=1
	fi

	if [[ ! -z $DOWNLOAD ]]; then
		[[ -e ${file_name} ]] && rm -rf $file_name
		curl -LO ${url}
	fi
}

docker_run() {
	docker run -it --rm -v $(pwd):/data \
		-e MAX_HEAP_SIZE=${MAX_HEAP_SIZE} \
		-e FAMILY_NAME=${FAMILY_NAME} \
		-e DESCRIPTION="${DESCRIPTION}" \
		-e PRODUCT_VERSION=${PRODUCT_VERSION} \
		-e MAP_NAME=${MAP_NAME} \
		-e STYLE=${STYLE} \
		-e TYP=${TYP} \
		ludw/mkgmap
}