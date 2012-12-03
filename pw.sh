#!/bin/sh

# file layout:
# ID | user_name | pwgen

PWFILE=~/.pwman

DMENU=dmenu
[ -f ~/.dmenurc ] && . ~/.dmenurc

[ ! -f $PWFILE ] && touch $PWFILE

choice=`cat "$PWFILE" | ${DMENU} -l 7`

if [ "$choice" == "" ]; then
	exit
fi

uid=`echo "$choice" | cut -d'|' -f2 | sed -E -e 's/[[:space:]]+//g'`
pgen=$(sh -c "$(echo "$choice" | cut -d'|' -f3-)")

if [ "$uid" == "" ]; then
	uid=`echo "$pgen" | sed 1q`
	pgen=`echo "$pgen" | sed -n -e '2p;2q'`
fi

uid=`echo "$uid" | sed -E -e 's/^[[:space:]]+//g' -e 's/[[:space:]]+$//g'`

echo -n "$uid" | xsel -i -t 2000
notify-send -t 5000 "User ID copied. You have 2 seconds..."
sleep 5

echo -n "$pgen" | xsel -i -t 2000
notify-send -t 5000 "Password copied. You have 2 seconds..."
sleep 5
echo $RANDOM | xsel -i
notify-send "Password erased."
