#!/bin/bash

source ../config.sh

docker run \
    -dit \
    --restart unless-stopped \
    --publish 8080:8080 \
    --network $NETWORK \
    --ip 10.1.0.3 \
    --name $PROXY_NAME \
    seedbox/proxy
