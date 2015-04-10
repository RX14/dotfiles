#!/bin/sh
PATH=$HOME/bin:$PATH

background start-pulseaudio-x11
imwheel

sleep 1

xmodmap /home/rx14/.Xmodmap

i3-msg 'workspace "1: web1"'
background chromium
wait-for-window Chromium

i3-msg 'workspace "4: web2"'
background chromium
sleep 5

i3-msg 'workspace "9: web3"'
background chromium
sleep 5

i3-msg 'workspace "0: dev3"'
background terminology
wait-for-window Terminology
sleep 2
i3-msg '[class="terminology"] move container to workspace "0: dev3"'

i3-msg 'workspace "2: dev2"'
background terminology
sleep 5

i3-msg 'workspace "5: dev1"'
background terminology
sleep 5

background lightscreen
background env LD_LIBRARY_PATH="" STEAM_RUNTIME=0 steam
#background spotify
background hexchat
background skype
background dropboxd start
background bluedevil-monolithic
background pasystray
background thunderbird
#background whatpulse

COUNTER=0
while [  $COUNTER -lt 240 ]; do
    xmodmap /home/rx14/.Xmodmap
    sleep 0.5
    let COUNTER=COUNTER+1
done
