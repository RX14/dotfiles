[[ -s ~/.xrandrrc ]] && source ~/.xrandrrc

[[ -s ~/.Xresources ]] && xrdb -merger ~/.Xresources

xset -dpms
xset s off

exec i3 2>&1 >> ~/.i3/log
