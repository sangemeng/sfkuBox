FROM ubuntu:latest
ENV TZ=Asia/Shanghai
ENV ss_password=none
ENV kcptun_password=none
ENV udp2raw_password=none
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
ADD server_install.sh /server_install.sh
RUN chmod +x /server_install.sh
ENTRYPOINT ["/bin/bash", "/server_install.sh"]
EXPOSE 10002 10003 10005 10006 8888