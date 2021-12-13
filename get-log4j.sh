#!/bin/bash

SEARCH_PATTERN=log4j2*
SERVERS_FILE="$(dirname '$0')"/servers.txt
SSH_OPTIONS="-n -o StrictHostKeyChecking=no -p587"
RUSER=root

if [[ ! -f $SERVERS_FILE ]]; then 
  echo "ERROR: $SERVERS_FILE not exists!"
  exit 1
fi

LOGFILE=$(dirname "$0")/findings-log4j.txt
echo > $LOGFILE

while read SERVER; do
  echo -n "$SERVER;" >> $LOGFILE
  ssh $SSH_OPTIONS $RUSER@$SERVER "find / -type f -name $SEARCH_PATTERN" >> $LOGFILE
done < $SERVERS_FILE