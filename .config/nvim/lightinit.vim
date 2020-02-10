if empty(glob('~/.config/nvim/autoload/plug.vim'))
	  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
	      \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
	endif
call plug#begin()
	Plug 'jiangmiao/auto-pairs'	
	Plug 'scrooloose/nerdcommenter'
	Plug 'scrooloose/nerdtree'
	Plug 'christoomey/vim-tmux-navigator'
	"Looks
	Plug 'bling/vim-airline'
	Plug 'drewtempelmeyer/palenight.vim'
call plug#end()

set nocompatible
filetype plugin indent on
syntax enable 
set number
set rnu
set splitbelow
set splitright
set tabstop=4       " number of visual spaces per TAB
set softtabstop=4   " number of spaces in tab when editing
set shiftwidth=4    " number of spaces to use for autoindent
set expandtab       " tabs are space
set autoindent
set copyindent      " copy indent from the previous line
set hidden
set nobackup
set nowritebackup
set cmdheight=2

"NERDtree
tnoremap <Esc> <C-\><C-n>
nnoremap <leader>n :NERDTreeToggle<CR>
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif

"Some bs that might help with airline performance
if ! has('gui_running')
    set ttimeoutlen=10
    augroup FastEscape
        autocmd!
        au InsertEnter * set timeoutlen=0
        au InsertLeave * set timeoutlen=1000
    augroup END
endif

if (has("nvim"))
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif
if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

"set background=dark
colorscheme palenight
let g:palenight_terminal_italics=1
let g:airline_theme = "palenight"
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:load_doxygen_syntax=1
hi! Normal ctermbg=NONE guibg=NONE
