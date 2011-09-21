#!/bin/sh
USERS="$(/bin/awk -F: '{ if (($3 < 500) && ($3 !=0)) print $1}' /etc/passwd)"
for u in $USERS
do
 /usr/bin/passwd -S $u |  /bin/awk '$2 !~ /LK/ {print $1 ", is not locked but appears to be a system account"}'
done

