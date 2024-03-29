[[ $TERM == "dumb" ]] && unsetopt zle && PS1='$ ' && return

### COMPLETION ###
zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle ':completion:*' expand prefix suffix
zstyle ':completion:*' file-sort name
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' ignore-parents parent pwd .. directory
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' list-suffixes true
zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]}' 'r:|[._-]=** r:|=**' 'l:|=* r:|=*'
zstyle ':completion:*' max-errors 2
zstyle ':completion:*' menu select=0
zstyle ':completion:*' preserve-prefix '//[^/]##/'
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' squeeze-slashes true
zstyle ':completion:*' use-compctl true
zstyle :compinstall filename "$ZDOTDIR/.zshrc"

autoload -Uz compinit bashcompinit
compinit
bashcompinit
fpath+="$ZDOTDIR/autoload"

if which gr >/dev/null 2>&1; then
#    source <(gr completion)
fi

### ANTIGEN ###
if [[ ! -d $ADOTDIR/source/ ]]; then
    echo "Installing Antigen..."
    mkdir -p $ADOTDIR/source/
    git clone https://github.com/zsh-users/antigen.git $ADOTDIR/source/
fi

source $ADOTDIR/source/antigen.zsh

antigen use oh-my-zsh

BULLETTRAIN_TIME_12HR=true

BULLETTRAIN_CONTEXT_FG=red
if [[ $(hostname) == "uiharu.iscute.moe" ]]; then
    BULLETTRAIN_CONTEXT_DEFAULT_USER=rx14
fi

BULLETTRAIN_DIR_EXTENDED=2

BULLETTRAIN_STATUS_EXIT_SHOW=true

BULLETTRAIN_PROMPT_ORDER=(
    time
    status
    custom
    context
    dir
    screen
    git
    hg
    cmd_exec_time
)

antigen theme caiogondim/bullet-train-oh-my-zsh-theme bullet-train

antigen bundles <<EOBUNDLES
colored-man-pages
docker
gem
gradle
lein
mercurial
mvn
pip
sbt
scala
sudo
systemd
vagrant

zsh-users/zsh-completions src
zsh-users/zsh-history-substring-search
zsh-users/zsh-syntax-highlighting
EOBUNDLES

antigen apply

### OTHER ###

source $ZDOTDIR/.aliases

bindkey '^H' backward-kill-word
bindkey "^Q" push-input
setopt interactivecomments

eval "$(dircolors $XDG_CONFIG_HOME/dircolors)"

mkdir -p -m700 "$GNUPGHOME"

if [[ $(basename "$(cat "/proc/$PPID/comm")") == "$TERMINAL" ]] && mkdir /tmp/rx14startupstuff 2>/dev/null; then
    read -r -k 1 "REPLY?:: Start update? [Y/n] "
    echo

    if echo -n "$REPLY" | grep -Pzq '^[Yy\n]$'; then
        time update
    fi
fi

if [[ ! -d $XDG_DATA_HOME/emacs ]]; then
    echo "Installing Doom Emacs..."
    git clone https://github.com/hlissner/doom-emacs $XDG_DATA_HOME/emacs
fi

if [[ ! -d $ZDOTDIR/archlinux-update-modules ]]; then
    echo "Installing archlinux-update-modules..."
    git clone https://github.com/t-wissmann/archlinux-update-modules $ZDOTDIR/archlinux-update-modules
fi

[[ -e /usr/share/fzf/key-bindings.zsh ]] && source /usr/share/fzf/key-bindings.zsh
[[ -e /usr/share/fzf/completion.zsh ]] && source /usr/share/fzf/completion.zsh

[[ ! -d $XDG_DATA_HOME/zsh ]] && mkdir -p $XDG_DATA_HOME/zsh

# Set $? to 0 so the prompt doesn't show a failure on startup
true
