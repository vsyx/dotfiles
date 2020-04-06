set nocompatible
filetype plugin indent on
syntax enable 

"Toggles for various utils
let g:coc_start_at_startup = 1
let g:rainbow_active = 1
let g:indentLine_enabled = 0
let g:load_doxygen_syntax=1

if empty(glob('~/.config/nvim/autoload/plug.vim'))
	  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
	      \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
	endif
call plug#begin()
	Plug 'neoclide/coc.nvim', {'branch': 'release'}

	Plug 'jiangmiao/auto-pairs'	
	Plug 'scrooloose/nerdcommenter'

	Plug 'vim-scripts/DoxygenToolkit.vim'
	Plug 'chemzqm/vim-jsx-improve'
	Plug 'christoomey/vim-tmux-navigator' 
	Plug 'dhruvasagar/vim-table-mode'
	Plug 'tpope/vim-vinegar'
	Plug 'morhetz/gruvbox'
	Plug 'Yggdroot/indentLine'
	Plug 'luochen1990/rainbow'

	Plug 'bling/vim-airline' 
	Plug 'vim-airline/vim-airline-themes'
	Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
	Plug 'junegunn/fzf.vim'
call plug#end()
runtime autoload/floating_window.vim

"Coc extensions
let g:coc_global_extensions = [
            \'coc-snippets',
            \'coc-tsserver',
            \'coc-tslint-plugin',
            \'coc-python',
            \'coc-java',
            \'https://github.com/xabikos/vscode-javascript',
            \'https://github.com/dgileadi/vscode-java-decompiler'
            \]

"Mappings
"let mapleader=" "
map <SPACE> <leader>
nnoremap <leader><space> <Nop>

nnoremap gs gT

nnoremap <leader>q :q <CR>
nnoremap <leader>h :leftabove new <bar>Explore<CR>
nnoremap <leader>l :vsp <bar>Explore<CR>
nnoremap <leader>j :sp <bar>Explore<CR>
nnoremap <leader>k :aboveleft new <bar>Explore<CR>
nnoremap <leader>w :Texplore <CR>
nnoremap <unique> <c-9> <Plug>NetrwRefresh

tnoremap <Esc> <C-\><C-n>
autocmd! FileType fzf tnoremap <buffer> <esc> <c-c>

nnoremap <M-s> :Files~<CR>
nnoremap <C-s> :call ProjectFiles()<CR>
nnoremap <m-b> :Buffers<CR>

" Spaces & tabs
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
hi PmenuSel blend=0

" Misc
set mouse=a " tmux scrolling
set number
set rnu
set formatoptions+=t
set noshowmatch
set ignorecase
set splitbelow
set splitright

"Netrw
let g:netrw_liststyle = 3
let g:netrw_banner = 0
let g:netrw_bufsettings = 'noma nomod nu nobl nowrap ro'

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

"Syntax

" Zoom / Restore window.
function! s:ZoomToggle() abort
    if exists('t:zoomed') && t:zoomed
        execute t:zoom_winrestcmd
        let t:zoomed = 0
    else
        let t:zoom_winrestcmd = winrestcmd()
        resize
        vertical resize
        let t:zoomed = 1
    endif
endfunction
command! ZoomToggle call s:ZoomToggle()
nnoremap <silent> <C-A> :ZoomToggle<CR>

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

"function! ExploreProject()
"    let root = s:get_project_root()
"    call fzf#run(fzf#wrap({'source': 'fd -t d', 'dir': root, 'sink': 'Explore'}))
"endfunction



set hidden
set nobackup
set nowritebackup
set cmdheight=1
set updatetime=300
set shortmess+=c
set signcolumn=yes

function IsSnippet()
    let pumState = complete_info(['selected', 'items'])
    let pumIndex = pumState.selected >= 0 ? pumState.selected : 0
    return len(pumState.items) && pumState['items'][pumIndex]['kind'] == 'S'
endfunction

inoremap <silent><expr> <TAB>
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ pumvisible() ? coc#_select_confirm() : "\<TAB>"
      "\ <SID>check_back_space() ? "\<TAB>" :
      "\ coc#refresh()
"inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
inoremap <expr> <cr> complete_info(['selected'])["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

"function! s:check_back_space() abort
"  let col = col('.') - 1
"  return !col || getline('.')[col - 1]  =~# '\s'
"endfunction

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
nmap <silent> <leader>d <Plug>(coc-definition)
nmap <silent> <leader>y <Plug>(coc-type-definition)
nmap <silent> <leader>i <Plug>(coc-implementation)
nmap <silent> <leader>r <Plug>(coc-references)
nmap <silent> <leader>n <Plug>(coc-rename) 
nnoremap <silent> K :call <SID>show_documentation()<CR>
inoremap <silent><expr> <c-space> coc#refresh()
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>x  <Plug>(coc-codeaction)
nmap <leader>q  <Plug>(coc-fix-current)
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)
"set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

nnoremap <leader>a :CocAction <CR>
let g:coc_snippet_next = '<tab>'
let g:coc_snippet_prev = '<s-tab>'

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight') 
"| call CocActionAsync('doHover')

"echo synIDattr(synID(line("."), col("."), 1), NAME_FG_BG)
