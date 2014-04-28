#!/bin/sh

LISTEN_ADDRESS=192.168.1.1
# Down the DNSmasq formatted ad block list
wget -O - "http://pgl.yoyo.org/adservers/serverlist.php?hostformat=dnsmasq&showintro=0&mimetype=plaintext" | sed "s/127\.0\.0\.1/$LISTEN_ADDRESS/" > /etc/dnsmasq.adblock.conf

# Restart DNSmasq
/etc/init.d/dnsmasq restart
