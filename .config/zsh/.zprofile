export PATH="$HOME/.local/bin:$PATH:$GOPATH/bin"

[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx ~/.config/X11/xinitrc
