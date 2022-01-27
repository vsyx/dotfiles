fpath=(
  $fpath
)
plugins=(virtualenv)

[ -f $XDG_CONFIG_HOME/aliases ]&&  source $XDG_CONFIG_HOME/aliases

HISTSIZE=100000
SAVEHIST=100000
HISTFILE=$ZDOTDIR/hist

setopt autocd
setopt interactive_comments
unsetopt beep

# Basic auto/tab complete:
#autoload -Uz compinit promptinit && compinit -U
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.

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

# Prompt
setopt prompt_subst
git_branch_prompt() {
    echo "%F{190}$(git symbolic-ref --short HEAD 2> /dev/null)%f"
}
function virtualenv_info { 
    [ $VIRTUAL_ENV ] && echo "%F{51}$(basename $VIRTUAL_ENV)%f " 
}

prompt() {
    PROMPT="%F{161}%5c%f $(git_branch_prompt) $(virtualenv_info)"
}
precmd_functions+=(prompt)

#prompt_personal_setup() {
    #PROMPT="%F{161}%5c%f $(git_branch_prompt) "
#}

#export PROMPT="%F{161}%5c%f $(git_branch_prompt) "
#prompt_themes+=(personal)
#prompt personal

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

bindkey '^j' down-history
bindkey -M vicmd '^j' down-history

bindkey '^k' up-history
bindkey -M vicmd '^k' up-history

x11-clip-wrap-widgets copy $copy_widgets
x11-clip-wrap-widgets paste  $paste_widgets

export LS_COLORS='di=1;35:fi=0:ln=90:ex=92:tw=0:ow=0'

#Autojump
[[ -s /home/$HOME/.autojump/etc/profile.d/autojump.sh ]] \
    && source /home/$HOME/.autojump/etc/profile.d/autojump.sh

# Syntax highlight has to be at the end
source $XDG_CONFIG_HOME/fzf/fzf.zsh

# pyenv
eval "$(pyenv init -)"

#nvm
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

[ -f /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ] \
    && source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Check if there's anything that should be executed upon starting the shell
if [[ $1 == eval ]]
then
    "$@"
set --
fi
