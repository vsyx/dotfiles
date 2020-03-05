[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

declare IGNORE_FILE=$XDG_CONFIG_HOME/fzf/ignore.txt
declare FZF_COLORS=$FZF_DEFAULT_OPTS' --color=fg:#d0d0d0,bg:-1,hl:#d7005f --color=fg+:#d0d0d0,bg+:-1,hl+:#5fd7ff --color=info:#afaf87,prompt:#d7005f,pointer:#d7008f --color=marker:#87ff00,spinner:#af5fff,header:#87afaf'

export FZF_DEFAULT_COMMAND="fd -t f . --ignore-file $IGNORE_FILE"
export FZF_DEFAULT_OPTS="$FZF_COLORS --height 50% --reverse -m" 
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

cdfzf() {
    local dir=$(fd -H -t d --ignore-file $IGNORE_FILE . ~ | fzf --reverse --delimiter / --with-nth 4..)
    if [ $dir ]; then
        cd "$dir"
        clear
    fi
    zle reset-prompt
}

zle -N cdfzf
bindkey '^Q' cdfzf

# global

vimfzf() {
    local files=$(fd -H -t f --ignore-file $IGNORE_FILE . . | fzf --preview 'head -80 {}')
    if [ $files ]; then
        nvim $(echo "$files" | tr "\n" " ") -O
    fi
    zle reset-prompt
}

zle -N vimfzf
bindkey '^O' vimfzf
