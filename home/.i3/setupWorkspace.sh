#!/bin/sh
PATH=$HOME/bin:$PATH

background start-pulseaudio-x11
imwheel

sleep 1

xmodmap /home/rx14/.Xmodmap

i3-msg 'workspace "1: web"'
background chromium
wait-for-window Chromium

i3-msg 'workspace "2: dev"'
background terminology
wait-for-window Terminology

background lightscreen
#background env LD_LIBRARY_PATH="" STEAM_RUNTIME=0 steam
#background spotify
background hexchat
#background skype
#background dropboxd start
background bluedevil-monolithic
background pasystray
#background thunderbird
#background whatpulse

COUNTER=0
while [  $COUNTER -lt 240 ]; do
    xmodmap /home/rx14/.Xmodmap
    sleep 0.5
    let COUNTER=COUNTER+1
done
