export PATH="$HOME/.local/bin:$PATH:$GOPATH/bin"

[[ -z $WAYLAND_DISPLAY && $XDG_VTNR -eq 1 ]] && exec sway -V 2>&1 | logger -t sway
