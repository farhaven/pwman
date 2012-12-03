#!/bin/sh

# file layout
# ID | user name | seed for pwgen
PWFILE=~/.pw2.rc
DMENU=dmenu
[ -f ~/.dmenurc ] && . ~/.dmenurc

mkfifo -m 0600 /tmp/pwman.$$

choice=`cat "$PWFILE" | $DMENU -l 7`
if [ "x$choice" == x ]; then
	exit
fi
echo $choice

uid=`echo $choice | cut -d'|' -f2`
seed=`echo $choice | cut -d'|' -f3`

uid=`echo $uid | sed -e 's/^[[:space:]]+//' -e 's/[[:space:]]+$//'`
seed=`echo $seed | sed -e 's/^[[:space:]]+//' -e 's/[[:space:]]+$//'`

masterpw=`echo | $DMENU -nb "#000" -nf "#000" -p "Master password"`
echo -n  $masterpw > /tmp/pwman.$$ &
cat ~/.seed > /tmp/pwman.$$ &
pw=`pwgen -ncC -H /tmp/pwman.$$#${seed} 16 2`

if [ x$uid == x ]; then
	uid=`echo $pw | cut -d' ' -f1`
	pw=`echo $pw | cut -d' ' -f2`
else
	pw=`echo $pw | cut -d' ' -f1`
fi

rm /tmp/pwman.$$

echo -n "$uid" | xsel -i
notify-send -t 5000 "User ID copied. You have 5 seconds..."
sleep 5

echo -n "$pw" | xsel -i
notify-send -t 5000 "Password copied. You have 5 seconds..."
sleep 5

echo $RANDOM | xsel -i
notify-send "Password erased."
