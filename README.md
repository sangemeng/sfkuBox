## 说明

### Docker 说明

#### 端口

```sh
8888:	ss
10002:	kcptun
10003:	finalspeed
10005:	udp2raw_amd64_hw_aes_kcptun
10006:	udp2raw_amd64_hw_aes_finalspeed
=======================================
(外网映射端口，可自行更改)
28888:	ss
20002:	kcptun
20003:	finalspeed
20005:	udp2raw_amd64_hw_aes_kcptun
20006:	udp2raw_amd64_hw_aes_finalspeed
```

#### 环境变量

```dockerfile
ENV ss_password="You password"
ENV kcptun_password="You password"
ENV udp2raw_password="You password"
```

## 使用

### 搭建

```sh
git clone https://github.com/sangemeng/sfkuBox.git
cd sfkuBox/Docker/server/
docker build -t sfkubox .
docker run -itd -p 20002:10002/udp -p 20003:10003/udp -p 20005:10005 -p 20006:10006 -p 28888:8888 --name sfkubox sfkubox /bin/bash
```

### 客户端

```sh
# udp2raw
.\udp2raw_mp_wepoll -c -l 0.0.0.0:3333  -r 1.1.1.1:20006 -k "none" --raw-mode faketcp
# ss
go-shadowsocks2 -c 'ss://AEAD_CHACHA20_POLY1305:your-password@[server_address]:8488' \
    -verbose -socks :1080 -u -udptun :8053=8.8.8.8:53,:8054=8.8.4.4:53 \
                             -tcptun :8053=8.8.8.8:53,:8054=8.8.4.4:53
# kcptun
./client_darwin_amd64 -r "KCP_SERVER_IP:4000" -l ":8388" -mode fast2 -nocomp -autoexpire 900 -sockbuf 16777217 -dscp 46 -key "You password" -crypt salsa20
# finalspeed-noui
https://github.com/sangemeng/finalspeed-noui.git
```

