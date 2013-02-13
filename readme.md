PWman
=====

Setup
-----

Generate a seed file for pwgen: `dd if=/dev/random of=~/.seed bs=1 count=512`. Then create a `~/.pwman.rc` with entries in the
following format:

	ID | user name | seed for pwgen

Where ID is a free form string used to identify the entry. If the user name is ommitted and the entry has the following format

	ID | | seed

a username is also generated in addition to a password. Spaces are stripped from the seed and the user name. An example looks like
this:

	Amazon         | gbe | amazon
	Github         | gbe | github
	Something else |     | something

Usage
-----

Start `pw.sh`. A dmenu prompt will pop up. Select one of the entries to paste the user name into the X selection. It will stay there
for 3 seconds and then be replaced with the password, which will also stay there for 3 seconds. After that, the X selection will be
replaced with a random number to obscure the password. That's basically it.

Dependencies
------------

* dmenu
* xsel
* pwgen
* notify-send

`notify-send` can be ommitted but then it's much harder to see when the user name has been replaced by the password or when the
password has been cleared.
