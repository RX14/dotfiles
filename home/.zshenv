export GOPATH="$HOME/gocode"
export PATH="$GOPATH/bin:$PATH"

export PATH="$HOME/bin:$PATH" #Add local bin

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

export CDPATH=".:/data/programming"

export EDITOR="vim"

export TERMINAL="terminology"

export USE_CCACHE=1

export QT_STYLE_OVERRIDE="GTK+"

gnupginf="${HOME}/.gpg-agent-info"
[ -f $gnupginf ] && source $gnupginf
