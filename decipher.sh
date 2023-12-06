#!/bin/bash

LIST=list
KEY=key

for LOCATION in $(cat $LIST)
do
        for FILE in $(find $LOCATION -type f -name '*.enc')
        do
                openssl aes-128-cbc -pbkdf2 -iter 100000 -salt -pass file:"$KEY" -in "$FILE" -out ${FILE%.*} -d && rm -rf "$FILE"
        done
done

