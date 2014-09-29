sleep 1

i3-msg 'workspace "4: dev2"; layout tabbed'
background i3-sensible-terminal
wait-for-window Terminal

i3-msg 'workspace "5: dev1"; layout tabbed'
background i3-sensible-terminal
sleep 0.5

i3-msg 'workspace "1: web1"'
background chromium-browser
wait-for-window Chromium
#wait-for-window "Tabs Outliner"
#i3-msg '[class="Chromium-browser" instance="crx_eggkanocgddhmamlbiijnphhppkpkmkl"] focus; move left; resize shrink width 1000 px or 36 ppt'

i3-msg 'workspace "2: web2"'
background chromium-browser
sleep 2

i3-msg 'workspace "3: other"; layout tabbed'
background steam
background exo-open /home/rx14/.local/share/applications/spotify.desktop
background thunderbird
background hexchat
background lightscreen
background dropbox start
background bluedevil-monolithic
background skype
background kmix
