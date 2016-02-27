export GOPATH="$HOME/gocode"
export PATH="$GOPATH/bin:$PATH"

export PATH="$HOME/bin:$PATH" #Add local bin

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

export PATH="$HOME/.crenv/bin:$PATH"

export PATH="$HOME/.cabal/bin:$PATH"

export CDPATH=".:/data/programming"

export EDITOR="gvim -f --servername GVIM --remote-tab"

export TERMINAL="terminology"

export USE_CCACHE=1

export QT_STYLE_OVERRIDE="GTK+"

gnupginf="${HOME}/.gpg-agent-info"
[ -f $gnupginf ] && source $gnupginf

SAVEHIST=1000000
HISTSIZE=10000
