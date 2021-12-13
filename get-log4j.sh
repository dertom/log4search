#!/bin/bash

SEARCH_PATTERN=log4j2*
SERVERS_FILE="$(dirname '$0')"/servers.txt


if [[ ! -f $SERVERS_FILE ]]; then 
  echo "ERROR: $SERVERS_FILE not exists!"
  exit 1
fi

LOGFILE=$(dirname "$0")/findings-log4j.txt
echo > $LOGFILE

while read SERVER; do
  echo -n "$SERVER;" >> $LOGFILE
  ssh -n -o StrictHostKeyChecking=no -p587 root@$SERVER "find / -type f -name $SEARCH_PATTERN" >> $LOGFILE
done < $SERVERS_FILE