#!/usr/bin/env sh

# Set up the base environment for the user.
if [ -r /etc/profile ]; then
    . /etc/profile
fi

# Pulseaudio is needed for audio over rdo
export PULSE_SCRIPT=/etc/xrdp/pulse/default.pa
pulseaudio --start --exit-idle-time=-1 &

# Autocutsel is needed for cut/paste to 
# work in programs like xterm
autocutsel -fork
autocutsel -selection PRIMARY -fork

# Go scowering for user preferences, if 
# none, start i3 by default.
if [ -f "$HOME/.xinitrc" ]; then
    exec "$HOME/.xinitrc"

elif [ -f "$HOME/.xsession" ]; then
    exec "$HOME/.xsession"

elif command -v i3 >/dev/null 2>&1; then
    exec i3
else
    exec xterm
fi

exit 1
