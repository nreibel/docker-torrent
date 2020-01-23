FROM ubuntu
MAINTAINER Nicolas Reibel (nicolas.reibel@gmail.com)

RUN apt-get -yqq update
RUN apt-get -yqq dist-upgrade
RUN apt-get -yqq install transmission-daemon openvpn
# RUN apt-get -yqq install iputils-ping nano curl

COPY rootfs/ /

RUN chmod +x /root/start.sh

HEALTHCHECK CMD ip a | grep -q tun0

ENTRYPOINT ["/bin/bash", "-c", "/root/start.sh"]
