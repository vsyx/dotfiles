set nocompatible
filetype plugin indent on
syntax enable 

let g:coc_start_at_startup = 0
let g:rainbow_active = 1
let g:indentLine_enabled = 0
let g:load_doxygen_syntax = 0
let g:colorizer_auto_filetype = 'css,html'

if empty(glob('$XDG_CONFIG_HOME/nvim/autoload/plug.vim'))
	  silent !curl -fLo ~$XDG_CONFIG_HOME/nvim/autoload/plug.vim --create-dirs
	      \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
	endif
call plug#begin()
	Plug 'neoclide/coc.nvim', {'branch': 'release'}

	Plug 'jiangmiao/auto-pairs'	
	Plug 'scrooloose/nerdcommenter'
	Plug 'junegunn/fzf.vim'
	Plug 'bling/vim-airline' 
	Plug 'lambdalisue/fern.vim'

	Plug 'dhruvasagar/vim-table-mode'
	Plug 'luochen1990/rainbow'
	Plug 'alvan/vim-closetag'
	Plug 'tommcdo/vim-lion'
	Plug 'sheerun/vim-polyglot'
	Plug 'arecarn/vim-crunch'

	"Plug 'vim-scripts/DoxygenToolkit.vim'
	"Plug 'chemzqm/vim-jsx-improve'
	"Plug 'chrisbra/Colorizer' 
	"Plug 'morhetz/gruvbox'
	
	"Plug 'justinmk/vim-sneak'
	"Plug 'hsanson/vim-android'
	"Plug 'tpope/vim-dadbod' DB wrapper
	"Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
	"Plug 'sunaku/vim-dasht'
	"Plug 'christoomey/vim-tmux-navigator' 
	"Plug 'tpope/vim-vinegar' lightweight fern
	"Plug 'justinmk/vim-dirvish'
	"Plug 'vim-airline/vim-airline-themes'
	"Plug 'Yggdroot/indentLine'
	Plug 'jiangmiao/auto-pairs'	
	Plug 'scrooloose/nerdcommenter'
	Plug 'scrooloose/nerdtree'
	Plug 'christoomey/vim-tmux-navigator'
	"Looks
	Plug 'bling/vim-airline'
call plug#end()

augroup filetype-changes
    autocmd!
    autocmd BufEnter *.fxml set ft=html
augroup END

nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

let g:closetag_filenames = '*.html,*.xhtml,*.phtml'
let g:closetag_filetypes = 'html,xhtml,phtml,xml'

"Mappings
"let mapleader=" "
map <SPACE> <leader>
nnoremap <leader><space> <Nop>
nnoremap gs gT
nnoremap <silent> <leader>q :q <CR>
nnoremap <silent> <leader>h :leftabove new <bar>Fern <C-r>=<SID>smart_path()<CR><CR>
nnoremap <silent> <leader>l :vsp <bar>Fern <C-r>=<SID>smart_path()<CR><CR>
nnoremap <silent> <leader>j :sp <bar>Fern <C-r>=<SID>smart_path()<CR><CR>
nnoremap <silent> <leader>k :aboveleft new <bar>Fern <C-r>=<SID>smart_path()<CR><CR>
nnoremap <silent> <leader>w :tabe <bar> Fern <C-r>=<SID>smart_path()<CR><CR>
nnoremap <silent>         - :Fern <C-r>=<SID>smart_path()<CR><CR>
tnoremap <Esc> <C-\><C-n>
nnoremap <silent><M-s> :call ProjectFiles()<CR>
nnoremap <m-b> :Buffers<CR>
autocmd! FileType fzf tnoremap <buffer> <esc> <c-c>

set tabstop=4       " number of visual spaces per TAB
set softtabstop=4   " number of spaces in tab when editing
set shiftwidth=4    " number of spaces to use for autoindent
set expandtab       " tabs are space
set autoindent
set copyindent      " copy indent from the previous line
set mps+=<:>
set scrolloff=5
set nojoinspaces "J 1 space instead of 2
set fillchars=eob:\ 
set numberwidth=1
set pumblend=15
set winblend=15
set mouse=a " tmux scrolling
set number
set rnu
set formatoptions+=t
set noshowmatch
set ignorecase
set splitbelow
set splitright
set hidden
set nobackup
set nowritebackup
set cmdheight=1
set updatetime=300
set shortmess+=c
set signcolumn=yes
hi PmenuSel blend=0

"Netrw
"let g:netrw_liststyle = 3
"let g:netrw_banner = 0
"let g:netrw_bufsettings = 'noma nomod nu nobl nowrap ro'
"nnoremap <silent> <unique> <c-9> <Plug>NetrwRefresh
"
let g:AutoPairs = {'(':')', '[':']', '{':'}',"'":"'",'"':'"', "`":"`", '```':'```', '"""':'"""', "'''":"'''"}

function! s:smart_path() abort
  if !empty(&buftype) || bufname('%') =~# '^[^:]\+://'
    return fnamemodify('.', ':p')
  endif
  return fnamemodify(expand('%'), ':p:h')
endfunctio

function! s:init_fern() abort
  nunmap <buffer> <C-h>
  nunmap <buffer> <C-j>
  nunmap <buffer> <C-k>
  nunmap <buffer> <C-l>
  nmap <buffer><expr>
        \ <Plug>(fern-my-collapse-or-leave)
        \ fern#smart#drawer(
        \   "\<Plug>(fern-action-collapse)",
        \   "\<Plug>(fern-action-leave)",
        \ )
  nmap <buffer><nowait> - <Plug>(fern-my-collapse-or-leave)
  nmap <buffer><nowait> S <Plug>(fern-action-mark-toggle)
endfunction

augroup fern-custom
  autocmd! *
  autocmd FileType fern call s:init_fern()
augroup END

" Disable netrw
let g:loaded_netrw             = 1
let g:loaded_netrwPlugin       = 1
let g:loaded_netrwSettings     = 1
let g:loaded_netrwFileHandlers = 1

augroup my-fern-hijack
  autocmd!
  autocmd BufEnter * ++nested call <SID>hijack_directory()
augroup END

function! s:hijack_directory() abort
  if !isdirectory(expand('%'))
    return
  endif
  exec 'Fern '. expand('%')
endfunction

"Looks
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme="badcat"
let g:airline_powerline_fonts = 1
colorscheme hashpunk-sweet
highlight Normal guibg=none

if (has("nvim"))
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif
if exists('+termguicolors')
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
    set termguicolors
endif

function! s:get_git_root()
    let l:res = split(system('git rev-parse --show-toplevel'), '\n')[0]
    return v:shell_error == 0 ? l:res : 0
endfunction

function! s:get_coc_root()
    for workspace in g:WorkspaceFolders
        if stridx(expand('%:p'), workspace) != '-1'
            return workspace
        endif
    endfor
endfunction

function! Get_project_root()
    let l:sources = [function('s:get_git_root'), function('s:get_coc_root')]
    for Source in l:sources
        let l:dict = call(Source, [])
        if !empty(l:dict) 
            return l:dict
        endif
    endfor
endfunction

function! ProjectFiles()
    let l:gitRoot = s:get_git_root()
    if !empty(l:gitRoot) 
        execute "GFiles -co --exclude-standard"
        return 1
    endif

    let l:cocRoot = s:get_coc_root()
    if !empty(l:cocRoot) 
        execute "FZF " . l:cocRoot
        return 1
    endif
endfunction
