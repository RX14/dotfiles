export PATH="$HOME/.local/bin:/usr/lib/ccache/bin:$PATH:$GOPATH/bin:$ANDROID_NDK"

if [[ -z $WAYLAND_DISPLAY && $XDG_VTNR -eq 1 ]]; then
    ulimit -n 10240
    exec sway -V 2>&1 | logger -t sway
fi
