#!/bin/bash

FTPSERVER=172.16.6.1

ftp -n $FTPSERVER 21 << EOF
user user01 user01
lcd /test 
cd test
bin
hash
prompt
mput linux*.txt
quit
EOF
