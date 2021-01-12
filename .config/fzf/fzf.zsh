# Fuzzy completion
[[ $- == *i* ]] && source "$XDG_CONFIG_HOME/nvim/plugged/fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
[ -f "$XDG_CONFIG_HOME/nvim/plugged/fzf/shell/key-bindings.zsh" ] && source "$XDG_CONFIG_HOME/nvim/plugged/fzf/shell/key-bindings.zsh"

bindkey -r '^T' # remove default ctrl-t

IGNORE_FILE=$XDG_CONFIG_HOME/fzf/ignore.txt
FZF_COLORS=$FZF_DEFAULT_OPTS' --color=fg:#d0d0d0,bg:-1,hl:#d7005f --color=fg+:#d0d0d0,bg+:-1,hl+:#5fd7ff --color=info:#afaf87,prompt:#d7005f,pointer:#d7008f --color=marker:#87ff00,spinner:#af5fff,header:#87afaf'

export FZF_DEFAULT_COMMAND="fd -H -t f . --ignore-file $IGNORE_FILE"
export FZF_DEFAULT_OPTS="$FZF_COLORS --height 50% --reverse" 

get_level() {
    expr "$(readlink -f $1 | tr -cd '/' | wc -c)" + ${2:-0}
}

ctrl_s_fzf() {
    local files="$(fd -H -t f --ignore-file $IGNORE_FILE . ~ | fzf -m --reverse --delimiter / --with-nth 4.. | tr '\n' ' ')"
    if [[ -z "${LBUFFER// }" && ! -z "$files" ]]; then
        $EDITOR $(echo "$files" | tr '\n' ' ') -O
        preexec
    else
        LBUFFER="$LBUFFER$files"
    fi
    zle reset-prompt
}
zle -N ctrl_s_fzf
bindkey '^S' ctrl_s_fzf

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

git_fzf() {
    local basedir=$(git rev-parse --show-toplevel 2>/dev/null) 
    [ ! $basedir ] && return 1

    local files="$(cd $basedir && git ls-files -cmo --exclude-standard | sort | uniq | sed "s,^,$basedir/," \
        | fzf -m --reverse --delimiter / --with-nth $(get_level $basedir 1).. | tr '\n' ' ')"

    if [[ -z "${LBUFFER// }" && ! -z "$files" ]]; then
        $EDITOR $(echo "$files" | tr '\n' ' ') -O
        preexec
    else
        LBUFFER="$LBUFFER$files"
    fi
    zle reset-prompt
}

zle -N git_fzf
bindkey '^G' git_fzf


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

