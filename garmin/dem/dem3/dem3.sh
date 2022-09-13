#!/bin/bash
set +x

#http://viewfinderpanoramas.org/Coverage%20map%20viewfinderpanoramas_org3.htm

URL=http://viewfinderpanoramas.org/dem3/


for i in A B C D E F G H I J K L M N O P Q R S T U SA SB SC SD SE SF SG SH SI SJ SK SL SM SN
do
	for j in `seq -w 1 60`
	do
		final_file=${i}${j}.zip
		final_url=${URL}${final_file}
		if ! [ -f $final_file ]; then
			curl -I -s ${final_url} | grep -q "Content-Type: application/zip" && curl -LO ${final_url}
		fi
	done
done
