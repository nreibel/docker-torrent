FROM alpine
MAINTAINER Nicolas Reibel (nicolas.reibel@gmail.com)
RUN apk update
RUN apk upgrade
RUN apk add transmission-daemon openvpn
ADD rootfs.tar.gz /
COPY login.conf /root/login.conf
RUN chmod +x /root/start.sh
HEALTHCHECK CMD ip a | grep -q tun0
ENTRYPOINT ["/bin/sh", "-c", "/root/start.sh"]
