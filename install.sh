#!/bin/bash

source config.sh

docker stop $PROXY_NAME $TORRENT_NAME 2>/dev/null

docker system prune --all --force

if ! docker network list | grep $NETWORK >/dev/null 2>&1
then
    docker network create -d bridge --subnet 10.1.0.0/24 $NETWORK
fi

if [ -e $VPN_LOGIN ]
then
    cp $VPN_LOGIN ./transmission/rootfs/etc/openvpn/pia/login.conf
fi

# Build Proxy
pushd ./proxy
./build.sh
./run.sh
popd

# Build Transmission
pushd ./transmission
./build.sh
./run.sh
popd
