#!/bin/bash
apt-get update
apt-get install unzip wget -y

mkdir /sfkubox
cd /sfkubox

# ss-go
wget --no-check-certificate "https://raw.githubusercontent.com/sangemeng/sfkuBox/main/ss/shadowsocks2-linux.zip"
unzip shadowsocks2-linux.zip
rm -rf shadowsocks2-linux.zip
chmod +x /sfkubox/shadowsocks2-linux

# kcptun
wget --no-check-certificate "https://raw.githubusercontent.com/sangemeng/sfkuBox/main/kcptun/kcptun-linux-amd64-20201010.zip"
unzip kcptun-linux-amd64-20201010.zip
rm -rf kcptun-linux-amd64-20201010.zip
chmod +x /sfkubox/server_linux_amd64

#udp2raw
wget --no-check-certificate "https://raw.githubusercontent.com/sangemeng/sfkuBox/main/udp2raw/udp2raw_amd64.zip"
unzip udp2raw_amd64.zip
rm udp2raw_amd64.zip
cp udp2raw_amd64_hw_aes udp2raw_amd64_hw_aes_finalspeed
cp udp2raw_amd64_hw_aes udp2raw_amd64_hw_aes_kcptun
chmod +x /sfkubox/udp2raw_amd64_hw_aes_finalspeed
chmod +x /sfkubox/udp2raw_amd64_hw_aes_kcptun
chmod +x /sfkubox/udp2raw_amd64

# finalspeed
apt-get -y install libpcap-dev
apt-get -y install iptables
apt-get install -y default-jre
mkdir /fs/
cd /fs/
wget --no-check-certificate "https://raw.githubusercontent.com/sangemeng/sfkuBox/main/finalspeed/finalspeed1.2_server.zip"
unzip finalspeed1.2_server.zip
rm -rf finalspeed1.2_server.zip
mkdir /fs/cnf/
echo "10003" > /fs/cnf/listen_port

# start
apt autoclean
apt clean
bash /fs/start.sh
#nohup /sfkubox/shadowsocks2-linux -s ss://AEAD_CHACHA20_POLY1305:password@:8888 >/dev/null 2>&1 &
nohup /sfkubox/server_linux_amd64 -t "127.0.0.1:8888" -l ":10002" -key $kcptun_password -crypt salsa20 -mode fast2 -nocomp -sockbuf 16777217 -dscp 46 >/dev/null 2>&1 &
nohup /sfkubox/udp2raw_amd64_hw_aes_kcptun -s -l0.0.0.0:10005 -r127.0.0.1:10002   -k $udp2raw_password --raw-mode faketcp >/dev/null 2>&1 &
nohup /sfkubox/udp2raw_amd64_hw_aes_finalspeed -s -l0.0.0.0:10006 -r127.0.0.1:10003   -k $udp2raw_password --raw-mode faketcp >/dev/null 2>&1 &
/sfkubox/shadowsocks2-linux -s ss://AEAD_CHACHA20_POLY1305:$ss_password@:8888