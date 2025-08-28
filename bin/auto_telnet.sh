#!/bin/bash

Cmd() {
	sleep 4 ; echo 'user01'
	sleep 1 ; echo 'user01'
	sleep 1 ; echo 'hostname'
	sleep 1 ; echo 'ls -l'
	sleep 1 ; echo 'exit'
}
Cmd | telnet localhost 

