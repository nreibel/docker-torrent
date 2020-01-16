#!/bin/bash

INTERFACE=tun0

if ip a | grep -q "$INTERFACE"; then
        echo "VPN connected on $INTERFACE"
else
        echo "Restarting VPN & Transmission daemon"
        service openvpn restart
        service transmission-daemon restart
fi
