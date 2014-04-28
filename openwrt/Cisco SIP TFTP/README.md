Cisco SIP Phone running from TFTP
==============

add the following to the dnsmasq config section in /etc/config/dhcp

	option enable_tftp '1'
        option tftp_root '/mnt/tftp'

and put files in /mnt/tftp

You will have to get a hold of the P003-8-12-00 image files for the Cisco 7940 and also some ring tones mentioned in RINGLIST.DAT
