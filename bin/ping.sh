#!/bin/bash

START=200
END=230
NET=172.16.6
FILE=/tmp/tmp1
/bin/cp /root/bin/position.txt $FILE

for i in $(seq $START $END)
do
    ping -c 1 -W 0.5 $NET.$i >/dev/null 2>&1 
    if [ $? -eq 0 ]; then
        echo "[  OK  ] $NET.$i"
        sed -i "s/$i/000/" $FILE
    else
        echo "[ FAIL ] $NET.$i"
        sed -i "s/$i/XXX/" $FILE
    fi
done

cat << EOF

$(cat /root/bin/position.txt)

$(cat $FILE)


EOF
