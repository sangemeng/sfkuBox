#!/bin/bash
apt-get update
apt-get install unzip wget

# ss-go


# finalspeed
apt-get -y install libpcap-dev
apt-get -y install iptables
apt-get install -y openjdk-7-jre
mkdir /fs/
cd /fs/
wget --no-check-certificate "https://raw.githubusercontent.com/sangemeng/sfkuBox/main/finalspeed/finalspeed1.2_server.zip"
unzip finalspeed1.2_server.zip
rm -rf finalspeed1.2_server.zip

# 