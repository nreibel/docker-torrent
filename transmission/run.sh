#!/bin/bash

source ../config.sh

docker run \
    -dit \
    --restart unless-stopped \
    --publish 9091:9091 \
    --privileged \
    --device=/dev/net/tun \
    --dns=8.8.8.8 \
    --dns=8.8.4.4 \
    --name $TORRENT_NAME \
    --network $NETWORK \
    --ip 10.1.0.2 \
    -v /public/Torrents:/public \
    seedbox/transmission
