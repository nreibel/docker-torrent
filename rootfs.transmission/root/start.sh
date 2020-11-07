#!/bin/sh

USER=transmission
IF_VPN=tun0
IF_INTERNAL=eth0

openvpn --config /etc/openvpn/pia/pia_nl.conf --daemon

while sleep 1
do
    if ip a | grep -q $IF_VPN
    then break;
    else echo "Waiting for $IF_VPN..."
    fi
done

iptables -F

# Setup firewall rules to bind transmission-torrent to VPN
iptables -A OUTPUT -m owner --uid-owner $USER -d 10.1.0.0/24 -j ACCEPT
iptables -A OUTPUT -m owner --uid-owner $USER -o $IF_VPN -j ACCEPT
iptables -A OUTPUT -m owner --uid-owner $USER -o lo -j ACCEPT
iptables -A OUTPUT -m owner --uid-owner $USER -j REJECT

# Not needed - but added these to properly track data to these interfaces when using iptables -L -v
iptables -A INPUT -i $IF_VPN -j ACCEPT
iptables -A INPUT -i $IF_INTERNAL -j ACCEPT
iptables -A INPUT -i lo -j ACCEPT

# Track any forward (NAT) data for completeness - don't care about interfaces
iptables -A FORWARD

transmission-daemon --config-dir /etc/transmission-daemon

# TODO : run as transmission user
# chown $USER /var/lib/transmission
# sudo -u $USER transmission-daemon --config-dir /etc/transmission-daemon

/bin/sh
