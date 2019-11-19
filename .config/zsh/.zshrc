# Lines configured by zsh-newuser-install

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
bindkey '^e' edit-command-line
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

# Use beam shape cursor on startup.
echo -ne '\e[5 q'

# Use beam shape cursor for each new prompt.
preexec() {
    echo -ne '\e[5 q'
}

setopt PROMPT_SUBST
git_branch() {
    echo "%F{197}$(git symbolic-ref --short HEAD 2> /dev/null)%f"
}
PROMPT='%F{205}%5c%f $(git_branch) '

typeset -A ZSH_HIGHLIGHT_STYLES

#ZSH_HIGHLIGHT_STYLES[alias]=none
#ZSH_HIGHLIGHT_STYLES[builtin]=none
#ZSH_HIGHLIGHT_STYLES[function]=none
ZSH_HIGHLIGHT_STYLES[command]=none
#ZSH_HIGHLIGHT_STYLES[precommand]=none
#ZSH_HIGHLIGHT_STYLES[commandseparator]=none
#ZSH_HIGHLIGHT_STYLES[hashed-command]=none
ZSH_HIGHLIGHT_STYLES[path]=none
ZSH_HIGHLIGHT_STYLES[globbing]=none

# Syntax highlight has to be at the end
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
