#!/bin/bash

#HOSTS=/etc/hosts
HOSTS=/root/bin/hosts
/bin/cp /etc/hosts $HOSTS

# 등록된 상태를 다시 등록하지 않도록 
# if grep -q -w linux230 "$HOSTS" ; then
#     echo "[ INFO ] 내용이 미리 등록된 것 같습니다."
#     exit
# fi

# 자신 IP를 확인
IP=$(ip addr show ens192 | grep 'inet ' | awk '{print $2}' | awk -F/ '{print $1}' | awk -F. '{print $4}')

for i in $(seq 200 230)
do
    [ "$IP" -eq "$i" ] && continue
    echo "172.16.6.$i  linux$i.example.com  linux$i" >> "$HOSTS"
done
