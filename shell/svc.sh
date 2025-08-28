#!/bin/bash
#   # svc start sshd
#   -> systemctl enable sshd
#   -> systemctl reload-or-restart sshd
#   # svc stop sshd
#   -> systemctl disable sshd
#   -> systemctl stop sshd
if [ $# -ne 2 ]; then
    echo "Usage: $0 <start|stop> <UNIT>"
    exit 1
fi
ACTION=$1
UNIT=$2

# 유닛 존재 유무 점검
systemctl list-unit-files | /bin/grep -q --color -w "$UNIT"
if [ $? -ne 0 ]; then
    echo "[ FAIL ] $UNIT을 찾을 수 없습니다."
    exit 2
fi

_START() {
    systemctl enable "$UNIT"
    systemctl reload-or-restart "$UNIT"
}

_STOP() {
    systemctl disable "$UNIT"
    systemctl stop "$UNIT"
}

case $ACTION in
    start) _START ;;
    stop)  _STOP ;;
    *)      echo "Usage: $0 <start|stop> <UNIT>" 
            exit 1 ;;
esac




