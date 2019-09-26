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
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR"/gnupg/S.gpg-agent.ssh
export VAGRANT_HOME="$XDG_DATA_HOME"/vagrant
export WINEPREFIX="$XDG_DATA_HOME"/wineprefixes/default
export bower_storage__links="$XDG_DATA_HOME"/bower/links
export bower_storage__packages="$XDG_DATA_HOME"/bower/packages
export bower_storage__registry="$XDG_DATA_HOME"/bower/registry
export npm_config_devdir="$XDG_CACHE_HOME"/node-gyp

export ANDROID_HOME=/opt/android-sdk
export ANDROID_NDK=/opt/android-ndk
export ANDROID_NDK_HOME="$ANDROID_NDK"

# ZSH History

HISTFILE=$XDG_DATA_HOME/zsh/history
SAVEHIST=1000000
HISTSIZE=10000
setopt INC_APPEND_HISTORY

# Misc

export _JAVA_OPTIONS="-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true -Djava.util.prefs.userRoot=$XDG_CONFIG_HOME/java"
export _JAVA_AWT_WM_NONREPARENTING=1

if [[ -n "$DISPLAY" ]]; then
    export EDITOR="emacsclient -c"
else
    export EDITOR="vim"
fi

export TERMINAL="terminology"

export GTK_THEME="Vertex-Dark"
export QT_QPA_PLATFORMTHEME=gtk2

export ELM_SCALE=1.25
export GDK_DPI_SCALE=1.25
export QT_FONT_DPI=120

export MOZ_ENABLE_WAYLAND=1
export ELM_DISPLAY=wl

# Needed for waybar tray
export XDG_CURRENT_DESKTOP=Unity

export BAT_STYLE=plain
export BAT_PAGER=

export MPW_FULLNAME='Christopher John Hobbs'
