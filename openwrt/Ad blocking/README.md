Ad blocking from the router level
==============

pixelserv.init.d to be placed in /etc/init.d/pixelserv
pixelserv.bin to be placed in /usr/bin/pixelserv
chmod a+x of /etc/init.d/pixelserv
chmod a+x /usr/bin/pixelserv

use the same address as in pixelserv.bin and add a section to /etc/config/network.

 #used for adblocking pixelserv
config interface 'lan2'
        option ifname 'br-lan'
        option proto 'static'
        option ipaddr '192.168.1.1'
        option netmask '255.255.255.0'


modify /etc/config/uhttpd to listen only to one address instead of all
        # HTTP listen addresses, multiple allowed
        list listen_http        192.168.0.1:80
 	#list listen_http        [::]:80

        # HTTPS listen addresses, multiple allowed
        list listen_https       192.168.0.1:443
 	#list listen_https       [::]:443


install the necessary packages for pixelserv.bin
opkg updated
opkg install perl perlbase-config perlbase-errno perlbase-essential perlbase-io perlbase-selectsaver perlbase-socket perlbase-symbol perlbase-xsloader

add as last line to /etc/dnsmasq.conf
conf-file=/etc/dnsmasq.adblock.conf

create the dnsmasq.adblock.conf on another linux/unix system with the script

#!/usr/local/bin/bash
# creates a dnsmasq compatible blocking list for ads
# should be used on the router to prevent adverts

ad_list_url="http://pgl.yoyo.org/adservers/serverlist.php?hostformat=dnsmasq&showintro=0&mimetype=plaintext"
pixelserv_ip="192.168.1.1"
ad_file="/tmp/dnsmasq.adblock.conf"
temp_ad_file="/tmp/dnsmasq.adblock.conf.tmp"

curl $ad_list_url | sed "s/127\.0\.0\.1/$pixelserv_ip/" > $temp_ad_file

if [ -f "$temp_ad_file" ]
then
        #sed -i -e '/www\.favoritesite\.com/d' $temp_ad_file
        mv $temp_ad_file $ad_file
else
        echo "Error building the ad list, please try again."
        exit
fi

A shorter script can be found in get-ad-block-list.sh

