IPv6 Tunnel through Sixxs using AYIYA
==============

aiccu.init.d to be placed in /etc/init.d/aiccu
aiccu.bin to be placed in /usr/sbin/aiccuaiccu
aiccu.config to be placed in /etc/config/aiccu
radvd.config to /etc/config/radvd

add a new section to /ect/config/network for a new interface

config 'interface' 'wan6'
        option 'proto' 'none'
        option 'ifname' 'sixxs'
        option 'auto' '1'
        #option 'ip6addr' 'our IPv6 address of the tunnel'
        #option 'ip6gw' 'their IPv6 address of the tunnel'
        option 'send_rs' '0'

edit /etc/config/firewall and add IPv6 sections

config rule
        option name 'Allow-DHCPv6'
        option src 'wan'
        option proto 'udp'
        option src_ip 'fe80::/10'
        option src_port '547'
        option dest_ip 'fe80::/10'
        option dest_port '546'
        option family 'ipv6'
        option target 'ACCEPT'

config rule
        option name 'Allow-ICMPv6-Input'
        option src 'wan'
        option proto 'icmp'
        list icmp_type 'echo-request'
        list icmp_type 'echo-reply'
        list icmp_type 'destination-unreachable'
        list icmp_type 'packet-too-big'
        list icmp_type 'time-exceeded'
        list icmp_type 'bad-header'
        list icmp_type 'unknown-header-type'
        list icmp_type 'router-solicitation'
        list icmp_type 'neighbour-solicitation'
        list icmp_type 'router-advertisement'
        list icmp_type 'neighbour-advertisement'
        option limit '1000/sec'
        option family 'ipv6'
        option target 'ACCEPT'

config rule
        option name 'Allow-ICMPv6-Forward'
        option src 'wan'
        option dest '*'
        option proto 'icmp'
        list icmp_type 'echo-request'
        list icmp_type 'echo-reply'
        list icmp_type 'destination-unreachable'
        list icmp_type 'packet-too-big'
        list icmp_type 'time-exceeded'
        list icmp_type 'bad-header'
        list icmp_type 'unknown-header-type'
        option limit '1000/sec'
        option family 'ipv6'
        option target 'ACCEPT'
