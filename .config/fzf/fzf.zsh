[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Fuzzy completion
[[ $- == *i* ]] && source "$HOME/.config/nvim/plugged/fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "$HOME/.config/nvim/plugged/fzf/shell/key-bindings.zsh"

declare IGNORE_FILE=$XDG_CONFIG_HOME/fzf/ignore.txt
declare FZF_COLORS=$FZF_DEFAULT_OPTS' --color=fg:#d0d0d0,bg:-1,hl:#d7005f --color=fg+:#d0d0d0,bg+:-1,hl+:#5fd7ff --color=info:#afaf87,prompt:#d7005f,pointer:#d7008f --color=marker:#87ff00,spinner:#af5fff,header:#87afaf'

export FZF_DEFAULT_COMMAND="fd -H -t f . --ignore-file $IGNORE_FILE"
export FZF_DEFAULT_OPTS="$FZF_COLORS --height 50% --reverse" 

#export FZF_CTRL_T_COMMAND="fd -H -t f --ignore-file $IGNORE_FILE . ~"

ctrl_t_fzf() {
    local files="$(fd -H -t f --ignore-file $IGNORE_FILE . ~ | fzf -m --reverse --delimiter / --with-nth 4.. | tr '\n' ' ')"
    if [[ -z "${LBUFFER// }" && ! -z "$files" ]]; then
        $EDITOR $(echo "$files" | tr '\n' ' ') -O
        preexec
    else
        LBUFFER="$LBUFFER$files"
    fi
    zle reset-prompt
}
zle -N ctrl_t_fzf
bindkey '^T' ctrl_t_fzf

cdfzf() {
    local dir=$(fd -H -t d --ignore-file $IGNORE_FILE . ~ | fzf --reverse --delimiter / --with-nth 4.. +m)
    if [ $dir ]; then
        cd "$dir"
        clear
    fi
    zle reset-prompt
}

zle -N cdfzf
bindkey '^Q' cdfzf

# vimfzf() {
    #local files=$(fd -H -t f --ignore-file $IGNORE_FILE . . | fzf -m)
    #if [ $files ]; then
        #nvim $(echo "$files" | tr "\n" " ") -O
        #preexec
    #fi
    #zle reset-prompt
#}

#zle -N vimfzf
#bindkey '^S' vimfzf

