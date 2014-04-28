#! /bin/sh /etc/rc.common
# /etc/init.d/pixelserv
#
START=50

# Carry out specific functions when asked to by the system
start() {
     echo "Starting pixelserv "
     /usr/bin/pixelserv &
    }
stop() {
     echo "Stopping script pixelserv"
     killall pixelserv
     }
