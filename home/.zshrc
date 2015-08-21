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
zstyle :compinstall filename '/home/rx14/.zshrc'

autoload -Uz compinit bashcompinit
compinit
bashcompinit

. <(gr completion)

### ANTIGEN ###
[[ ! -d ~/.antigen/source/ ]] &&
	mkdir -p ~/.antigen/source/ && git clone https://github.com/zsh-users/antigen.git ~/.antigen/source/

. ~/.antigen/source/antigen.zsh

antigen use oh-my-zsh

BULLETTRAIN_PROMPT_CHAR="\$"

BULLETTRAIN_TIME_SHOW=true

BULLETTRAIN_STATUS_EXIT_SHOW=true

BULLETTRAIN_CONTEXT_SHOW=true
BULLETTRAIN_CONTEXT_FG=green
BULLETTRAIN_CONTEXT_DEFAULT_USER=rx14

antigen theme caiogondim/bullet-train-oh-my-zsh-theme bullet-train

antigen bundles <<EOBUNDLES
autojump
colored-man
docker
gem
gradle
lein
mercurial
mvn
npm
pip
sbt
scala
sudo
systemd
vagrant

zsh-users/zsh-completions src
zsh-users/zsh-history-substring-search
zsh-users/zsh-syntax-highlighting

djui/alias-tips
EOBUNDLES

antigen apply

### ALIASES ###
source ~/.aliases

### AGENTS ###
function start-gpg-agent() {
  if pgrep -x -u "${USER}" gpg-agent >/dev/null 2>&1; then
  else
      gpg-agent -s --enable-ssh-support --daemon --log-file ~/.gnupg/gpg-agent.log > $gnupginf
  fi
  source $gnupginf
}
function gpg-reboot() { killall -u "$USER" gpg-agent; start-gpg-agent }

start-gpg-agent
### OTHER ###

. `which resty`

[ -f /home/rx14/.travis/travis.sh ] && source /home/rx14/.travis/travis.sh

export USE_CCACHE=1

function mkcd () { mkdir -p "$@" && eval cd "\"\$$#\""; }

if [[ ( ! -f /tmp/rx14startupstuff ) && ( ! -z $DISPLAY && $XDG_VTNR -eq 1 ) ]]; then
    touch /tmp/rx14startupstuff

    yaourt -Su --devel --noconfirm
    yaourt -Syu --aur
    sudo pkgcacheclean -v 2
fi

source /home/rx14/.rvm/scripts/rvm
