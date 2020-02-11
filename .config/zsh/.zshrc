zmodload zsh/complist

if [ -f $XDG_CONFIG_HOME/aliases ]; then
    source $XDG_CONFIG_HOME/aliases
fi

HISTSIZE=1000
SAVEHIST=1000
HISTFILE=$ZDOTDIR/hist

autoload -Uz compinit promptinit && compinit -U
zstyle ':completion:*' menu select gain-privileges 1
compinit
_comp_options+=(globdots)
promptinit

unsetopt beep
autoload edit-command-line; zle -N edit-command-line
bindkey -v
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

#Autojump
[[ -s /home/tixxy/.autojump/etc/profile.d/autojump.sh ]] && source /home/tixxy/.autojump/etc/profile.d/autojump.sh

# fzf
[ -f $XDG_CONFIG_HOME/fzf/fzf.zsh ] && source $XDG_CONFIG_HOME/fzf/fzf.zsh 
#bindkey -r '^[c' # unbind default fzf cd search

stty -ixon # unbind C-S
stty -ixoff # unbind C-Q

function x11-clip-wrap-widgets() {
    # NB: Assume we are the first wrapper and that we only wrap native widgets
    # See zsh-autosuggestions.zsh for a more generic and more robust wrapper
    local copy_or_paste=$1
    shift

    for widget in $@; do
        # Ugh, zsh doesn't have closures
        if [[ $copy_or_paste == "copy" ]]; then
            eval "
            function _x11-clip-wrapped-$widget() {
                zle .$widget
                xclip -in -selection clipboard <<<\$CUTBUFFER
            }
            "
        else
            eval "
            function _x11-clip-wrapped-$widget() {
                CUTBUFFER=\$(xclip -out -selection clipboard)
                zle .$widget
            }
            "
        fi

        zle -N $widget _x11-clip-wrapped-$widget
    done
}


local copy_widgets=(
    vi-yank vi-yank-eol 
)
local paste_widgets=(
    vi-put-{before,after}
)

# NB: can atm. only wrap native widgets
x11-clip-wrap-widgets copy $copy_widgets
x11-clip-wrap-widgets paste  $paste_widgets

# Syntax highlight has to be at the end
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
