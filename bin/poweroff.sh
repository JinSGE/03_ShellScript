#!/bin/bash

SERVERLIST=/root/bin/server.list
cat << EOF > $SERVERLIST
server1
server2
EOF

for SERVER in $(cat $SERVERLIST)
do
    ssh $SERVER poweroff
    sleep 3
done
sleep 5

poweroff
sleep 2
