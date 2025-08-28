#!/bin/bash

# 변수 설정
LOGFILE=/var/log/messages
EMAIL=root
TMP1=/tmp/tmp1
TMP2=/tmp/tmp2
TMP3=/tmp/tmp3

# 0) 선수 패키지 설치
# yum -q -y install postfix s-nail
# systemctl enable --now postfix

# 1) 초기 로그 파일 생성
egrep -i --color 'warn|error|crit|fail|alert|emerg' "$LOGFILE" > "$TMP1"

# 2) 30초에 한번씩 로그 파일 점검
while true
do
    sleep 10
    egrep -i --color 'warn|error|crit|fail|alert|emerg' "$LOGFILE" > "$TMP2"
    diff "$TMP1" "$TMP2" > "$TMP3" && continue
    # 3) 관리자에게 메일 전송하기
    mailx -s "[CHECK] $LOGFILE check" "$EMAIL" < "$TMP3"
    # 4) 초기 로그 파일 다시 생성
    egrep -i --color 'warn|error|crit|fail|alert|emerg' "$LOGFILE" > "$TMP1"
done
