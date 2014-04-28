PC speaker
==============

To enable the PC speaker in FreeBSD, the speaker module needs to be loaded. Add following line in /boot/loader.conf
speaker_load="YES"

The files beeps and beeps2 contain some themese and notes, which need to be sent to /dev/speaker
