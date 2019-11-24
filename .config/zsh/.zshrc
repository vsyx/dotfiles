# Lines configured by zsh-newuser-install
zmodload zsh/complist

if [ -f $CONFIG/aliases ]; then
    source $CONFIG/aliases
fi

HISTSIZE=1000
SAVEHIST=1000
HISTFILE=$ZDOTDIR/hist

autoload -Uz compinit promptinit
zstyle ':completion:*' menu select gain-privileges 1
compinit
_comp_options+=(globdots)
promptinit

unsetopt beep
bindkey -v
autoload edit-command-line; zle -N edit-command-line
bindkey '^w' edit-command-line
export KEYTIMEOUT=1

function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

bindkey "^?" backward-delete-char
bindkey -M menuselect '^[[Z' reverse-menu-complete

setopt PROMPT_SUBST
git_branch() {
    echo "%F{197}$(git symbolic-ref --short HEAD 2> /dev/null)%f"
}
PROMPT='%F{205}%5c%f $(git_branch) '

#typeset -A ZSH_HIGHLIGHT_STYLES
#ZSH_HIGHLIGHT_STYLES[alias]=none
#ZSH_HIGHLIGHT_STYLES[builtin]=none
#ZSH_HIGHLIGHT_STYLES[function]=none
#ZSH_HIGHLIGHT_STYLES[command]=none
#ZSH_HIGHLIGHT_STYLES[precommand]=none
#ZSH_HIGHLIGHT_STYLES[commandseparator]=none
#ZSH_HIGHLIGHT_STYLES[hashed-command]=none
#ZSH_HIGHLIGHT_STYLES[path]=none
#ZSH_HIGHLIGHT_STYLES[globbing]=none

# Syntax highlight has to be at the end
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
