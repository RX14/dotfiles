background start-pulseaudio-x11

sleep 1

xmodmap /home/rx14/.Xmodmap

i3-msg 'workspace "4: dev2"; layout tabbed'
sleep 10
background i3-sensible-terminal
wait-for-window "None"

i3-msg 'workspace "5: dev1"; layout tabbed'
background i3-sensible-terminal
sleep 5

i3-msg 'workspace "1: web1"'
background chromium
wait-for-window Chromium

i3-msg 'workspace "2: web2"'
background chromium
sleep 5

i3-msg 'workspace "6: mail"'
background thunderbird
wait-for-window Thunderbird

i3-msg 'workspace "3: other"; layout tabbed'
background steam
background spotify
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
