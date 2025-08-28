#!/bin/bash

SERVERLIST=/root/bin/server.list

cat $SERVERLIST | while read HOST UNAME UPASS
do
	Cmd() {
		sleep 2 ; echo "$UNAME"
		sleep 1 ; echo "$UPASS"
		sleep 1 ; echo 'hostname'
		sleep 1 ; echo 'exit'
	}
	Cmd | telnet $HOST
done
