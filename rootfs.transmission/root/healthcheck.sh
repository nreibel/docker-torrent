#!/bin/sh

INTERFACE="tun0"

if ! ip a | grep $INTERFACE
then
  echo "$INTERFACE is down"
  exit 1
fi

if ! ping -c 1 www.google.com
then
  echo "Network is unreachable"
  exit 1
fi

exit 0
