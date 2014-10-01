background start-pulseaudio-x11

sleep 1

xmodmap /home/rx14/.Xmodmap

i3-msg 'workspace "4: dev2"; layout tabbed'
sleep 1
background i3-sensible-terminal
wait-for-window "/bin/bash"

i3-msg 'workspace "5: dev1"; layout tabbed'
background i3-sensible-terminal
sleep 1

i3-msg 'workspace "1: web1"'
background chromium
wait-for-window Chromium

i3-msg 'workspace "2: web2"'
background chromium
sleep 2

i3-msg 'workspace "3: other"; layout tabbed'
background steam
background spotify
background thunderbird
background hexchat
background lightscreen
background dropboxd start
background bluedevil-monolithic
background skype
background pasystray

for a  in 1 2 3 4 5 6; do
    xmodmap /home/rx14/.Xmodmap
    sleep 10
done
