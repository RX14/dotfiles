# XDG
# This section attempts to place everything in XDG dirs by default
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_DOWNLOAD_DIR="$HOME/Downloads"

ZDOTDIR=$XDG_CONFIG_HOME/zsh
ADOTDIR=$XDG_DATA_HOME/antigen

export ANDROID_SDK_HOME="$XDG_CONFIG_HOME"/android
export ANDROID_SDK_ROOT="$XDG_CONFIG_HOME"/android
export BUNDLE_USER_CACHE="$XDG_CACHE_HOME"/bundle
export BUNDLE_USER_CONFIG="$XDG_CONFIG_HOME"/bundle
export BUNDLE_USER_PLUGIN="$XDG_DATA_HOME"/bundle
export CARGO_HOME="$XDG_DATA_HOME"/cargo
export CCACHE_DIR="$XDG_CACHE_HOME"/ccache
export DOCKER_CONFIG="$XDG_CONFIG_HOME"/docker
export DISTCC_DIR="$XDG_CACHE_HOME"/distcc
export GEM_HOME="$XDG_DATA_HOME"/gem
export GEM_SPEC_CACHE="$XDG_CACHE_HOME"/gem
export GNUPGHOME="$XDG_CONFIG_HOME"/gnupg
export GOPATH="$XDG_DATA_HOME"/go
export GRADLE_USER_HOME="$XDG_DATA_HOME"/gradle
export GTK2_RC_FILES="$XDG_CONFIG_HOME"/gtk-2.0/gtkrc
export HTTPIE_CONFIG_DIR="$XDG_CONFIG_HOME"/httpie
export LESSHISTFILE="$XDG_CACHE_HOME"/less/history
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME"/npm/npmrc
export OCTAVE_HISTFILE="$XDG_CACHE_HOME/"octave-hsts
export OCTAVE_SITE_INITFILE="$XDG_CONFIG_HOME"/octave/octaverc
export PLATFORMIO_HOME_DIR="$XDG_CACHE_HOME"/platformio
export RANDFILE="$XDG_CACHE_HOME"/openssl/rnd
export RUSTUP_HOME="$XDG_DATA_HOME"/rustup
export SSH_AUTH_SOCK="${SSH_AUTH_SOCK:-$XDG_RUNTIME_DIR/gnupg/S.gpg-agent.ssh}"
export VAGRANT_HOME="$XDG_DATA_HOME"/vagrant
export WINEPREFIX="$XDG_DATA_HOME"/wineprefixes/default
export bower_storage__links="$XDG_DATA_HOME"/bower/links
export bower_storage__packages="$XDG_DATA_HOME"/bower/packages
export bower_storage__registry="$XDG_DATA_HOME"/bower/registry
export npm_config_devdir="$XDG_CACHE_HOME"/node-gyp
export PSQLRC="$XDG_CONFIG_HOME"/psql
export PSQL_HISTORY="$XDG_DATA_HOME"/psql_history
export JULIA_DEPOT_PATH="$XDG_DATA_HOME"/julia:"$JULIA_DEPOT_PATH"

export ANDROID_HOME=/opt/android-sdk
export ANDROID_NDK=/opt/android-ndk
export ANDROID_NDK_HOME="$ANDROID_NDK"

# Set paths for PREFIX=~/.local
typeset -U PATH path
path=("$HOME/.local/bin" "/usr/lib/ccache/bin" $path "$GOPATH/bin" "$ANDROID_NDK")

typeset -xUT LIBRARY_PATH library_path :
library_path=("$HOME/.local/lib" $library_path)

typeset -xUT LD_LIBRARY_PATH ld_library_path :
ld_library_path=("$HOME/.local/lib" $ld_library_path)

typeset -xUT CPATH cpath :
cpath=("$HOME/.local/include" $cpath)

typeset -xUT PKG_CONFIG_PATH pkg_config_path :
pkg_config_path=("$HOME/.local/lib/pkgconfig" $pkg_config_path)

# ZSH History

HISTFILE=$XDG_DATA_HOME/zsh/history
SAVEHIST=1000000
HISTSIZE=10000
setopt INC_APPEND_HISTORY

# Misc

export _JAVA_OPTIONS="-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true -Djava.util.prefs.userRoot=$XDG_CONFIG_HOME/java"
export _JAVA_AWT_WM_NONREPARENTING=1

if [[ $(hostname) == "uiharu.iscute.moe" ]]; then
    export EDITOR="emacsclient -c"
else
    export EDITOR="vim"
fi

export TERMINAL="kitty"

export GTK_THEME="Vertex-Dark"
export QT_QPA_PLATFORMTHEME=gtk2

export MOZ_ENABLE_WAYLAND=1
export QT_QPA_PLATFORM=wayland-egl
export ECORE_EVAS_ENGINE=wayland_egl
export ELM_ENGINE=wayland_egl

# Needed for waybar tray
export XDG_CURRENT_DESKTOP=sway

export BAT_STYLE=plain
export BAT_PAGER=

export LMOD_PAGER=less

export MANSECT="2:3:1:n:l:8:0:5:4:9:6:7"

export CRYSTAL_OPTS="--link-flags=-fuse-ld=lld --progress"

if [[ $(hostname) == "uiharu.iscute.moe" ]]; then
    export CCACHE_PREFIX="distcc"
    export DISTCC_HOSTS="[203:ada2:f8d5:e206:dbc1:5c9a:d848:fce6]/28,lzo localhost/3"
    export DISTCC_BACKOFF_PERIOD=5
fi

if test -f "$ZDOTDIR"/.zshenv.priv; then
    source "$ZDOTDIR"/.zshenv.priv
fi
