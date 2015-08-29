#!/bin/sh
PATH=$HOME/bin:$PATH

background start-pulseaudio-x11
background chromium --no-startup-window --disable-new-avatar-menu
imwheel

sleep 2

i3-msg 'workspace "1: web1"'
chromium
sleep 0.5

i3-msg 'workspace "4: web2"'
chromium
sleep 0.5

i3-msg 'workspace "9: web3"'
chromium
sleep 0.5

i3-msg 'workspace "0: dev3"'
background terminology
wait-for-window Terminology
i3-msg '[class="terminology"] move container to workspace "0: dev3"'

i3-msg 'workspace "2: dev2"'
terminology

i3-msg 'workspace "5: dev1"'
terminology

i3-msg 'workspace "6: other"'
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
background chromium --app=https://web.whatsapp.com/

COUNTER=0
while [  $COUNTER -lt 240 ]; do
    xmodmap /home/rx14/.Xmodmap
    sleep 0.5
    let COUNTER=COUNTER+1
done
