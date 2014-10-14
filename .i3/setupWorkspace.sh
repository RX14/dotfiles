background start-pulseaudio-x11

sleep 1

xmodmap /home/rx14/.Xmodmap

i3-msg 'workspace "1: web1"'
background chromium
wait-for-window Chromium

i3-msg 'workspace "2: web2"'
background chromium
sleep 5

i3-msg 'workspace "4: dev2"'
background roxterm
wait-for-window ROXTerm
i3-msg '[class="Roxterm"] move container to workspace "4: dev2"'

i3-msg 'workspace "5: dev1"; for_window [class="Roxterm"] move container to workspace "5: dev1"'
background roxterm
sleep 5

background steam
background spotify
background hexchat
background lightscreen
background skype
background dropboxd start
background bluedevil-monolithic
background pasystray
background thunderbird

COUNTER=0
while [  $COUNTER -lt 240 ]; do
    xmodmap /home/rx14/.Xmodmap
    sleep 0.5
    let COUNTER=COUNTER+1
done
