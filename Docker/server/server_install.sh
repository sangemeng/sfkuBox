#!/bin/bash
apt-get update
apt-get install unzip wget
# finalspeed
apt-get -y install libpcap-dev
apt-get -y install iptables
apt-get install -y openjdk-7-jre
wget --no-check-certificate "https://raw.githubusercontent.com/sangemeng/finalspeed-1/master/fs1.2_server.zip"