#!/usr/bin/env bash

while IFS= read -r line
do
	if [[ $line != \#* ]] 
	then 
	  	# wget "$line"
	  	# out1=`curl -I  --stderr /dev/null $line | head -1 | cut -d' ' -f2`
		
		# echo $out1
		# out=`wget -q -c "$line"`
	  	out=`wget --server-response --spider --quiet "${line}" 2>&1`
	  	# echo $out
	  	if [ $? -ne 0 ]; then
	  		echo $line "FAILED"
	  	# if [[ `wget -S --spider $line  2>&1 | grep 'HTTP/1.1 200 OK'` ]]; then echo "true"; 
	  	#	else echo "false"; 
	  	#fi
	  	else 
	  		filename=`wget  -q -nv -N $line 2>&1 |cut -d\" -f2`
	  		# if [[ `wget -N $line  2>&1 | grep "304 Not Modified" ` ]]
	  		echo $filename 
	  		if [ ! -e "./$filename" ] 
	  		then
		  		wget -N -nv -q $line 2>&1 |cut -d\" -f2 
	  			echo $line INIT
	  		else
	  	#then 
	  		# File is the same - Nothing is shown
	  	#	:
	  	#else
	  			wget -nv -N $line -q 2>&1 |cut -d\" -f2 
	  			echo $line
	  		fi
	  	fi
	fi

done < "$1"
