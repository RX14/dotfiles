[[ -s ~/.xrandrrc ]] && source ~/.xrandrrc

[[ -s ~/.Xresources ]] && xrdb -merger ~/.Xresources

exec i3
