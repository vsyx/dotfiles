export XDG_CONFIG_HOME=$HOME/.config
export ZDOTDIR=$XDG_CONFIG_HOME/zsh

command -v nvim > /dev/null && export EDITOR=nvim
#export CONFIG=$XDG_CONFIG_HOME

#HIST files
export LESSHISTFILE="$XDG_CONFIG_HOME/.lesshst"
export NODE_REPL_HISTORY=''
export PYLINTHOME=$HOME/.cache/pylint
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
export MANPATH=":$HOME/.local/share/man"

path=("$HOME/.local/bin" $path)
export PATH

#export JAVA_HOME='/usr/lib/jvm/default'
