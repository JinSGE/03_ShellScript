#!/bin/bash

SERVERLIST=/root/bin/server.txt

cat $SERVERLIST | while read SERVER
do
    ftp -n $SERVER 21 << EOF
    user root soldesk1.
    cd /tmp
    lcd /test
    bin
    hash
    prompt
    mput linux230.txt
    quit
EOF
done
