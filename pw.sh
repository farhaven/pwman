#!/bin/sh

# Dependencies:
# * dmenu
# * xsel
# * pwgen
# * notify-send (optional, but recommended)

# file layout
# ID | user name | seed for pwgen

PWFILE=~/.pwman.rc
DMENU=dmenu
[ -f ~/.dmenurc ] && . ~/.dmenurc

choice=`cat "$PWFILE" | $DMENU -l 7`
if [ "x$choice" == x ]; then
	exit
fi
echo $choice

uid=`echo $choice | cut -d'|' -f2`
seed=`echo $choice | cut -d'|' -f3`

uid=`echo $uid | sed -e 's/^[[:space:]]+//' -e 's/[[:space:]]+$//'`
seed=`echo $seed | sed -e 's/^[[:space:]]+//' -e 's/[[:space:]]+$//'`

pw=`pwgen -ncC -H ~/.seed#${seed} 16 2`

if [ x$uid == x ]; then
	uid=`echo $pw | cut -d' ' -f1`
	pw=`echo $pw | cut -d' ' -f2`
else
	pw=`echo $pw | cut -d' ' -f1`
fi

echo -n "$uid" | xsel -i
notify-send -t 3000 "User ID copied. You have 3 seconds..."
sleep 3

echo -n "$pw" | xsel -i
notify-send -t 3000 "Password copied. You have 3 seconds..."
sleep 3

echo $RANDOM | xsel -i
notify-send "Password erased."
