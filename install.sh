#!/bin/bash

VOLUME="transmission-data"
NETWORK="transmission-net"
PROXY_NAME="proxy"
TORRENT_NAME="torrent"
TORRENT_FOLDER="/public"

if [ ! -f login.conf ]
then
	echo "login.conf does not exist"
	exit 1
fi

read -p "Delete previous Docker data? (Y/n): " DELETE
if [ "$DELETE" = "Y" ]
then docker system prune --all --force
fi

if ! docker network list | grep $NETWORK >/dev/null 2>&1
then docker network create -d bridge --subnet 10.1.0.0/24 $NETWORK
fi

if ! docker volume list | grep $VOLUME >/dev/null 2>&1
then docker volume create $VOLUME
fi

# cp 20-docker-transmission.conf /etc/sysctl.d/
# sysctl --system

# Build Proxy
docker build -f Dockerfile.proxy -t seedbox/$PROXY_NAME .
docker run -dit --restart unless-stopped \
    --publish 8080:8080 \
    --network $NETWORK \
    --ip      10.1.0.3 \
    seedbox/$PROXY_NAME

# Build Transmission
docker build -f Dockerfile.transmission -t seedbox/$TORRENT_NAME .
docker run -dit --restart unless-stopped \
    --privileged \
    --publish 9091:9091 \
    --device  /dev/net/tun \
    --dns     8.8.8.8 \
    --dns     8.8.4.4 \
    --network $NETWORK \
    --ip      10.1.0.2 \
    --volume  $TORRENT_FOLDER:/public \
    --volume  $VOLUME:/var/lib/transmission \
    seedbox/$TORRENT_NAME
