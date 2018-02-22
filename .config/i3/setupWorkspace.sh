#!/bin/sh

amixer set Master 30%

background pasystray
background thunderbird
background hexchat
background emacs --daemon
background dunst
run_keybase

i3-msg 'workspace "1: web1"'
background firefox
wait-for-window Firefox

i3-msg 'workspace "2: dev1"'
background terminology
sleep 1
i3-msg '[class="terminology"] move container to workspace "2: dev1"'

# i3-msg 'workspace "0: comms"'
i3-msg '[class="^Keybase$"] kill'

for i in $(seq 1 120); do
    xmodmap ~/.config/X11/Xmodmap
    sleep 0.5
done
