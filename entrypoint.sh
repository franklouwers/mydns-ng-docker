#!/bin/bash
/usr/bin/mysqld_safe --nowatch
sleep 5

# If /load.sql exists, load that dump into the mydns Database
[ -f /load.sql ] && mysql mydns < /load.sql

/usr/local/sbin/mydns

