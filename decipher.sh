#!/bin/bash

LIST=list
KEY=key

for LOCATION in $(cat $LIST)
do
	for FILE in $(find $LOCATION -type f -name '*.enc')
	do
        	openssl aes-128-cbc -salt -pass file:"$KEY" -in "$FILE" -out ${FILE%.*} -d && rm -rf "$FILE"
	done
done

