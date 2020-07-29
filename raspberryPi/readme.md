# install tmux

sudo apt-get update && sudo apt-get install -y tmux

# install vim

sudo apt-get update && sudo apt-get install -y vim

# setup keyboard properly (debian)

`sudo vim /etc/default/keyboard`

Make sure it's set to:

XKBMODEL="pc104"
XKBLAYOUT="us"
XKBVARIANT=""
XKBOPTIONS="caps:escape"

This will make it a US layout keyboard, and make caps-locks behave as another escape.
Then run:

`sudo setupcon`
