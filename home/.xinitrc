killall gpg-agent

[[ -s ~/.xrandrrc ]] && source ~/.xrandrrc

[[ -s ~/.Xresources ]] && xrdb -merger ~/.Xresources

[[ -s ~/.Xmodmap ]] && xmodmap ~/.Xmodmap

xset -dpms
xset s off

exec i3 2>&1 >> ~/.i3/log
