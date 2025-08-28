#!/bin/bash

set -e

##################
# 1) 통신 확인
##################
for i in 10 20 30
do
    ping -c 1 -W 1 192.168.10.$i >/dev/null 2>&1 \
      && echo "[  OK  ] 192.168.10.$i" \
      || echo "[ FAIL ] 192.168.10.$i"
done

############################
# 2) multi-user.target 변경
############################
# (ㄱ) 선수 패키지 설치
yum -q -y install sshpass

# (ㄴ) graphical.target -> multi-user.target으로 변경
for i in 20 30
do
    sshpass -p 'soldesk1.' ssh -o StrictHostKeyChecking=no "192.168.10.$i" \
        'systemctl set-default multi-user.target'
    sshpass -p 'soldesk1.' ssh -o StrictHostKeyChecking=no "192.168.10.$i" \
        'systemctl isolate multi-user.target'
done

###########################################
# 3) 스크린 락(Screen Lock) 해제, 절전 모드 끄기(Power Saving OFF)
###########################################
# (ㄱ) 관리자로 설정할 때
# 빈 화면 지연 시간: 안함
dconf write /org/gnome/desktop/session/idle-delay 0
# 자동 화면 잠금: 비활성화
dconf write /org/gnome/desktop/screensaver/lock-enabled false
# 전원 모드 설정: balanced 설정
dconf write /org/gnome/settings-daemon/plugins/power/power-profile "'balanced'"

#############################################
# 4) 방화벽 OFF, SELinux OFF
#############################################
for i in 10 20 30
do
    # (ㄱ) 방화벽 종료
    sshpass -p 'soldesk1.' ssh -o StrictHostKeyChecking=no 192.168.10.$i \
        systemctl disable --now firewalld
    # (ㄴ) SELinux 변경(enforcing -> permissive)
    sshpass -p 'soldesk1.' ssh -o StrictHostKeyChecking=no 192.168.10.$i \
        "sed -i 's/SELINUX=enforcing/SELINUX=permissive/' /etc/selinux/config"
    sshpass -p 'soldesk1.' ssh -o StrictHostKeyChecking=no 192.168.10.$i \
        "setenforce 0"   
done

################################
# 5) 공개키 인증 방식 설정
################################
# (ㄱ) 키 생성
yes | ssh-keygen -t rsa -f ~/.ssh/id_rsa -N ''

# (ㄴ) 키 배포
for i in 10 20 30
do
    sshpass -p 'soldesk1.' ssh-copy-id -o StrictHostKeyChecking=no \
        -i ~/.ssh/id_rsa.pub root@192.168.10.$i
done

# (ㄷ) 확인
for i in 10 20 30
do
    ssh 192.168.10.$i hostname
done

###################################
# 6) 한국어 설정 - 한글 키보드 사용
###################################
# 한국어(Hangul) 추가
gsettings set org.gnome.desktop.input-sources sources "[('ibus', 'hangul'), ('xkb', 'us')]"
gsettings get org.gnome.desktop.input-sources sources

####################################
# 7) 폰트 설정, PS1 설정, /etc/hosts 파일 생성
####################################
# (ㄱ) 선수 패키지 설치
yum -q -y install gnome-tweaks

# (ㄴ) 폰트 설정
gsettings set org.gnome.desktop.interface monospace-font-name 'Monospace Bold 18'

# (ㄷ) 확장(GNOME Extension) 기능 ON
for item in $(gnome-extensions list)
do
    gnome-extensions enable "$item"
done

# (ㄹ) Terminal 아이콘 생성
[ -d ~/바탕화면 ] && cp /usr/share/applications/org.gnome.Terminal.desktop ~/바탕화면
[ -d ~/Desktop  ] && cp /usr/share/applications/org.gnome.Terminal.desktop ~/Desktop 

#####################################
# 8) PS1 변수 설정
#####################################
# main:.bashrc -- copy --> server1|server2:.bashrc
# (ㄱ) ~/.bashrc 파일 생성
echo "export PS1='\[\e[31;1m\][\u@\h\[\e[33;1m\] \w]\\$ \[\e[m\]'" >> ~/.bashrc
source ~/.bashrc

# (ㄴ) ~/.bashrc 파일 다른 서버(server1|server2)로 복사
scp ~/.bashrc 192.168.10.20:.bashrc
scp ~/.bashrc 192.168.10.30:.bashrc

#######################################
# 9) /etc/hosts 파일 설정하기
#######################################
# (ㄱ) /etc/hosts 파일 생성
cat << EOF > /etc/hosts
127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4
::1         localhost localhost.localdomain localhost6 localhost6.localdomain6

192.168.10.10  main.example.com     main
192.168.10.20  server1.example.com  server1
192.168.10.30  server2.example.com  server2

EOF

# (ㄴ) /etc/hosts 파일 다른 서버(server1|server2)로 복사
scp /etc/hosts 192.168.10.20:/etc/hosts
scp /etc/hosts 192.168.10.30:/etc/hosts









