#!/bin/sh
PATH=$HOME/bin:$PATH

background start-pulseaudio-x11
background dunst
imwheel

sleep 2

xmodmap /home/rx14/.Xmodmap

i3-msg 'workspace "1: web"'
background firefox
wait-for-window "Mozilla Firefox"

i3-msg 'workspace "2: dev"'
background terminology
wait-for-window Terminology
i3-msg '[class="terminology"] move container to workspace "2: dev2"'

i3-msg 'workspace "3: other"'
#background env LD_PRELOAD='/usr/$LIB/libstdc++.so.6 /usr/$LIB/libgcc_s.so.1 /usr/$LIB/libxcb.so.1' steam
#background spotify
background hexchat
#background skype
#background dropboxd start
background bluedevil-monolithic
background pasystray
#background thunderbird
background synergy
#background whatpulse
#background chromium --app='https://web.whatsapp.com/'
#background chromium --app='https://tweetdeck.twitter.com/'
#background chromium --app='https://trcommunity.slack.com/messages/?no_ls=1'
#background chromium --app='https://discordapp.com/channels/@me'

COUNTER=0
while [  $COUNTER -lt 240 ]; do
    xmodmap /home/rx14/.Xmodmap
    sleep 0.5
    let COUNTER=COUNTER+1
done
