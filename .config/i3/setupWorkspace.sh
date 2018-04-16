#!/bin/sh

count_windows() {
    wmctrl -l | wc -l
}

block_until_gui_launched() {
    window_count=$(count_windows)
    background "${@}"
    while [[ $(count_windows) -eq ${window_count} ]]; do
        sleep 0.05
    done
    sleep 1
}

has_monitor() {
    xrandr | grep -q "$1 connected"
}

amixer set Master 30%

background thunderbird
background hexchat
background emacs --daemon
background dunst

i3-msg 'workspace "1: web1"'
block_until_gui_launched firefox
sleep 2
i3-msg '[class="Firefox"] move container to workspace "1: web1"'

i3-msg 'workspace "2: dev1"'
block_until_gui_launched terminology
sleep 1
i3-msg '[class="terminology"] move container to workspace "2: dev1"'

if has_monitor HDMI1; then
    i3-msg 'workspace "4: web2"'
    block_until_gui_launched firefox

    i3-msg 'workspace "5: dev2"'
    block_until_gui_launched terminology

    i3-msg 'workspace "8: web3"'
    block_until_gui_launched firefox

    i3-msg 'workspace "9: dev3"'
    block_until_gui_launched terminology
fi

i3-msg 'workspace "8: web3"'
i3-msg 'workspace "4: web2"'
i3-msg 'workspace "1: web1"'

for i in $(seq 1 30); do
    xmodmap ~/.config/X11/Xmodmap
    sleep 1
done
