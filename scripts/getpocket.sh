#!/bin/bash

set -euo pipefail

FILE=./linkding_getpocket.txt

rss-parser https://getpocket.com/users/juev/feed/all > $FILE
# Reading the URLs one by one and adding to linkding
while IFS= read -r line; do
	curl -s -X POST -H "Content-Type: application/json" -H "Accept: application/json" -H "Authorization: Token ${LINKDING_TOKEN}" https://link.juev.org/api/bookmarks/ -d "{\"url\":\"${line}\"}"
done < $FILE

rm $FILE
exit 0
