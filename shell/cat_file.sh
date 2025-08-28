#!/bin/bash

yum -q -y install vsftpd ftp

FTPUSERS=/etc/vsftpd/ftpusers

for UNAME in $(cat $FTPUSERS | egrep -v '^#|^$')
do
    echo "[ Blocked ] $UNAME"
done

