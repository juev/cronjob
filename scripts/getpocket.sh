#!/bin/bash

set -euo pipefail

FILE=./linkding_getpocket.txt
curl --retry-all-errors --retry 10 --retry-delay 0 --retry-max-time 40 --max-time 10 \
 https://github.com/juev/rss-parser/releases/latest/download/rss-parser-linux-amd64 \
 -L -s -o run
chmod +x run

./run https://getpocket.com/users/juev/feed/all > $FILE
# Reading the URLs one by one and adding to linkding
while IFS= read -r line; do
	curl -s -X POST -H "Content-Type: application/json" -H "Accept: application/json" -H "Authorization: Token ${LINKDING_TOKEN}" https://link.juev.org/api/bookmarks/ -d "{\"url\":\"${line}\"}"
done < $FILE

rm run $FILE
exit 0
