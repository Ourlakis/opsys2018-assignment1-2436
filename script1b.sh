#!/usr/bin/env bash


download () {
	local line=$1
	if [[ $line != \#* ]]
	then

			if curl --output /dev/null --silent --head --fail "$line"; then

				filename=${line////_}
				filename=${filename//:/_}

				if [ -e "$filename" ]; then
					if [[ "$(curl $line -z $filename -o $filename -s -L -w %{http_code})" == "200" ]]; then
  					# code here to process index.html because 200 means it gets updated
  					echo $line
					fi
				else
					echo $line "INIT"
					curl "$line" -o "$filename" -s
				fi
	  	else
		  	echo $line "FAILED"
	  	fi
	fi
}

while IFS= read -r line
do
	download "$line" &

done < "$1"
