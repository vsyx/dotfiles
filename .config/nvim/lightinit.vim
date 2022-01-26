set rtp+=~/.local/share/nvim/runtime
set nocompatible
filetype plugin indent on
syntax enable 

if has('win32')
    set shell=\"C:/Program\ Files/Git/bin/bash.exe\"
endif

let g:coc_start_at_startup = 0
let g:rainbow_active = 1
let g:indentLine_enabled = 0
let g:load_doxygen_syntax = 0
let g:colorizer_auto_filetype = 'css,html'
let g:AutoPairsShortcutToggle = ''
let g:AutoPairsFlyMode = 0
let python_highlight_space_errors = 0

let s:plug_vim = glob(has('nvim') ? '$XDG_CONFIG_HOME/nvim' : '$HOME/.vim') . '/autoload/plug.vim'
if !filereadable(s:plug_vim)
	  silent execute '!curl -fLo ' . s:plug_vim . ' --create-dirs ' 
          \ . 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
	  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
	endif
call plug#begin()
	"Plug 'neoclide/coc.nvim', {'branch': 'release'}
	
    Plug 'lambdalisue/fern.vim'
        " Disable netrw
        let g:loaded_netrw             = 1
        let g:loaded_netrwPlugin       = 1
        let g:loaded_netrwSettings     = 1
        let g:loaded_netrwFileHandlers = 1

        nnoremap <silent> <leader>h :leftabove new <bar>Fern <C-r>=<SID>smart_path()<CR><CR>
        nnoremap <silent> <leader>l :vsp <bar>Fern <C-r>=<SID>smart_path()<CR><CR>
        nnoremap <silent> <leader>j :sp <bar>Fern <C-r>=<SID>smart_path()<CR><CR>
        nnoremap <silent> <leader>k :aboveleft new <bar>Fern <C-r>=<SID>smart_path()<CR><CR>
        nnoremap <silent> <leader>w :tabe <bar> Fern <C-r>=<SID>smart_path()<CR><CR>
        nnoremap <silent>         - :Fern <C-r>=<SID>smart_path()<CR><CR>

        function! s:smart_path() abort
            if !empty(&buftype) || bufname('%') =~# '^[^:]\+://'
                return fnamemodify('.', ':p')
            endif
            return fnamemodify(expand('%'), ':p:h')
        endfunction

        function! s:init_fern() abort
            nunmap <buffer> <C-h>
            nunmap <buffer> <C-j>
            nunmap <buffer> <C-k>
            nunmap <buffer> <C-l>
            nmap <buffer><nowait> -         <Plug>(fern-action-leave)
            nmap <buffer><nowait> <Return>  <Plug>(fern-action-open)
            nmap <buffer><nowait> S         <Plug>(fern-action-mark-toggle)
        endfunction

        augroup fern-custom
          autocmd! *
          autocmd FileType fern call s:init_fern()
        augroup END

	Plug 'scrooloose/nerdcommenter' 
	Plug 'sheerun/vim-polyglot' 
	Plug 'rhysd/vim-grammarous'
        nmap <silent> <leader>gn <Plug>(grammarous-move-to-next-error)
        nmap <silent> <leader>gp <Plug>(grammarous-move-to-previous-error)
    Plug 'wellle/targets.vim'
    Plug 'camspiers/lens.vim'
	Plug 'junegunn/vim-slash'
    Plug 'junegunn/vim-after-object'
	Plug 'machakann/vim-highlightedyank'
	Plug 'michaeljsmith/vim-indent-object' 
    Plug 'unblevable/quick-scope'
        let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } " Default shell bindings
    Plug 'junegunn/fzf.vim'
        nnoremap <silent><C-s> :GFiles -co --exclude-standard <CR>

    Plug 'antoinemadec/FixCursorHold.nvim'
        let g:cursorhold_updatetime = 100

	"Plug 'tommcdo/vim-lion' " Aligning 
	"Plug 'jiangmiao/auto-pairs'	
	"Plug 'dhruvasagar/vim-table-mode'
	"Plug 'arecarn/vim-crunch' "Calculator
call plug#end()

"Colorscheme
colorscheme hashpunk-v3

function! s:cursor_move(direction) abort 
    if winnr() != winnr(a:direction)
        execute "wincmd " . a:direction
    elseif a:direction ==# 'l'
        call feedkeys("gt")
    elseif a:direction ==# 'h'
        call feedkeys("gT")
    endif
endfunction

"Mappings
map <SPACE> <leader>
nnoremap <leader><space> <Nop>
nnoremap <silent> <C-J> :call <SID>cursor_move('j')<CR>
nnoremap <silent> <C-K> :call <SID>cursor_move('k')<CR>
nnoremap <silent> <C-L> :call <SID>cursor_move('l')<CR>
nnoremap <silent> <C-H> :call <SID>cursor_move('h')<CR>
nnoremap <M-l> gt
nnoremap <M-h> gT

"Term
tnoremap <expr> <Esc> (&filetype == "fzf") ? "<Esc>" : "<c-\><c-n>"
tnoremap <silent> <C-J> <c-\><c-n>:call <SID>cursor_move('j')<CR>
tnoremap <silent> <C-K> <c-\><c-n>:call <SID>cursor_move('k')<CR>
tnoremap <silent> <C-L> <c-\><c-n>:call <SID>cursor_move('l')<CR>
tnoremap <silent> <C-H> <c-\><c-n>:call <SID>cursor_move('h')<CR>
tnoremap <M-l> <c-\><c-n>gt
tnoremap <M-h> <c-\><c-n>gT
augroup term_au
    autocmd!
    au BufEnter * if &buftype == 'terminal' | :startinsert | endif
    au TermOpen * setlocal nonumber norelativenumber statusline=%{b:term_title}
    au BufNewFile,BufRead *.asm   set syntax=nasm
augroup END

"Yanking
nnoremap <M-y> "+y
vnoremap <M-y> "+y 
nnoremap <M-p> "+p
vnoremap <M-p> "+p 
nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'
"if has('unnamedplus') | set clipboard+=unnamedplus | endif

set tabstop=4       " number of visual spaces per TAB
set softtabstop=4   " number of spaces in tab when editing
set shiftwidth=4    " number of spaces to use for autoindent
set expandtab       " tabs are space
set autoindent
set copyindent      " copy indent from the previous line
set mps+=<:>
set scrolloff=5
set nojoinspaces "J 1 space instead of 2
set numberwidth=1
set mouse=a " tmux scrolling
set number
set rnu
set formatoptions+=t
set formatoptions-=cro
set noshowmatch
set ignorecase
set splitbelow
set splitright
set hidden
set nobackup
set nowritebackup
set cmdheight=1
set laststatus=0
set updatetime=300
set shortmess+=c

if has('nvim-0.5')
    set signcolumn=number
else
    set signcolumn=auto:1
endif

if has("nvim")
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  set fillchars=eob:\ 
  set pumblend=15
  set winblend=15
  "hi PmenuSel blend=0
endif

if exists('+termguicolors')
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
    set termguicolors
endif

augroup remember_folds
  autocmd!
  autocmd BufWinLeave,BufLeave,BufWritePost,BufHidden,QuitPre ?* nested silent! mkview!
  autocmd BufWinEnter ?* silent! loadview
augroup END

func! Modified_color_prefix() abort
    return &modified ? "%1*" : "%0*"
endfunc

set rulerformat=%70(%=%{%Modified_color_prefix()%}%F\ %([%{&ff}\|%{(&fenc==\"\"?&enc:&fenc).((exists(\"+bomb\")\ &&\ &bomb)?\",B\":\"\")}%k\|%Y]%)\ %([%l,%v][%p%%]\ %)%)
