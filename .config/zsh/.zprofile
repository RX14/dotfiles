export PATH="$HOME/.local/bin:$PATH:$GOPATH/bin"

[[ -z $WAYLAND_DISPLAY && $XDG_VTNR -eq 1 ]] && exec sway
