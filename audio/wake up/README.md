Wake up
==============

Use crontab, a script and mpg321 like so

# alarm clock
5-20 7 * *  mon-fri /some/where/timeout3 -t 600 mpg321 http://media-ice.musicradio.com/ClassicFMMP3

The script checks, if mpg321 is still running every minute, and keeps the mpg321 at maximum 6 minutes alive from the last check
