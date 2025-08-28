#!/bin/bash

SERVERLIST=/root/bin/server.list
cat << EOF > $SERVERLIST
192.168.10.20
192.168.10.30
EOF

for host in $(cat $SERVERLIST)
do
    Cmd() {
        sleep 2 ; echo "root"
        sleep 1 ; echo "soldesk1."
        sleep 1 ; echo "tar cvzf /tmp/home.$host.tar.gz /home"
        sleep 1 ; echo 'exit'
    }
    Cmd | telnet $host

    ftp -n $host 21 << EOF
    user root soldesk1.
    cd /tmp
    lcd /root
    bin
    hash
    prompt
    mget home.$host.tar.gz
    quit
EOF
done

ls -l /root/home.*
