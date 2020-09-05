zmodload zsh/complist
fpath=(
  /usr/local/share/zsh/site-functions
  $fpath
)

[ -f $XDG_CONFIG_HOME/aliases ]&&  source $XDG_CONFIG_HOME/aliases

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
git_branch_prompt() {
    echo "%F{197}$(git symbolic-ref --short HEAD 2> /dev/null)%f"
}

docker_prompt() {
    [ ! -f  /.dockerenv ] && echo "" || echo "%F{44}🐋%f"
}

PROMPT='$(docker_prompt) %F{161}%5c%f $(git_branch_prompt) '

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

function run-again {
    zle up-history
    zle accept-line
}
zle -N run-again
bindkey '^P' run-again 
bindkey -M vicmd '^P' run-again 

x11-clip-wrap-widgets copy $copy_widgets
x11-clip-wrap-widgets paste  $paste_widgets

export LS_COLORS='di=1;35:fi=0:ln=90:ex=92:tw=0:ow=0'

#Autojump
[[ -s /home/$HOME/.autojump/etc/profile.d/autojump.sh ]] && source /home/$HOME/.autojump/etc/profile.d/autojump.sh

# Syntax highlight has to be at the end
source $XDG_CONFIG_HOME/fzf/fzf.zsh

[ -f /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ] && source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
