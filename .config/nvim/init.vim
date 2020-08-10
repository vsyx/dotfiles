set nocompatible
filetype plugin indent on
syntax enable 

"Toggles for various utils
let g:coc_start_at_startup = 1
let g:rainbow_active = 1
let g:indentLine_enabled = 0
let g:load_doxygen_syntax = 1
let g:colorizer_auto_filetype = 'css,html'
let g:AutoPairsShortcutToggle = ''

let g:android_sdk_path = "/home/tixxy/Android/Sdk"

if empty(glob('~/.config/nvim/autoload/plug.vim'))
	  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
	      \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
	endif
call plug#begin()
	Plug 'neoclide/coc.nvim', {'branch': 'release'}

	Plug 'jiangmiao/auto-pairs'	
	Plug 'scrooloose/nerdcommenter'
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
	Plug 'bling/vim-airline' 
	Plug 'lambdalisue/fern.vim'

	Plug 'vim-scripts/DoxygenToolkit.vim'
	Plug 'chemzqm/vim-jsx-improve'
	Plug 'dhruvasagar/vim-table-mode'
	Plug 'morhetz/gruvbox'
	Plug 'luochen1990/rainbow'
	Plug 'alvan/vim-closetag'
	Plug 'tommcdo/vim-lion'
	Plug 'chrisbra/Colorizer' 
	Plug 'sheerun/vim-polyglot'
	Plug 'arecarn/vim-crunch'
	
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
call plug#end()

augroup filetype-changes
    autocmd!
    autocmd BufEnter *.fxml set ft=html
augroup END

nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

nnoremap <M-y> "+y
vnoremap <M-y> "+y

let g:closetag_filenames = '*.html,*.xhtml,*.phtml'
let g:closetag_filetypes = 'html,xhtml,phtml,xml'

"nnoremap <silent> gK :call Dasht([expand('<cword>'), expand('<cWORD>')])<CR>

"Coc extensions
let g:coc_global_extensions = [
            \'coc-snippets',
            \'coc-tsserver',
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
nnoremap <silent> <leader>q :q <CR>
nnoremap <silent> <leader>h :leftabove new <bar>Fern <C-r>=<SID>smart_path()<CR><CR>
nnoremap <silent> <leader>l :vsp <bar>Fern <C-r>=<SID>smart_path()<CR><CR>
nnoremap <silent> <leader>j :sp <bar>Fern <C-r>=<SID>smart_path()<CR><CR>
nnoremap <silent> <leader>k :aboveleft new <bar>Fern <C-r>=<SID>smart_path()<CR><CR>
nnoremap <silent> <leader>w :tabe <bar> Fern <C-r>=<SID>smart_path()<CR><CR>
nnoremap <silent>         - :Fern <C-r>=<SID>smart_path()<CR><CR>
nnoremap <silent><C-s> :call ProjectFiles()<CR>
tnoremap <Esc> <C-\><C-n>
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


"augroup remember_folds
"  autocmd!
"  autocmd BufWinLeave * mkview
"  autocmd BufWinEnter * silent! loadview
"augroup END

"function! ExploreProject()
"    let root = s:get_project_root()
"    call fzf#run(fzf#wrap({'source': 'fd -t d', 'dir': root, 'sink': 'Explore'}))
"endfunction


inoremap <silent><expr> <TAB>
    \ coc#expandableOrJumpable() && !pumvisible() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
    \ pumvisible() ? coc#_select_confirm() : "\<TAB>"
"inoremap <expr> <cr> complete_info(['selected'])["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

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
"echo synIDattr(synID(line("."), col("."), 1), NAME_FG_BG)

"smart indent when entering insert mode with i on empty lines
"function! IndentWithI()
    "if len(getline('.')) == 0
        "return "\"_cc"
    "else
        "return "i"
    "endif
"endfunction
"nnoremap <expr> i IndentWithI()

" Zoom / Restore window.
"function! s:ZoomToggle() abort
    "if exists('t:zoomed') && t:zoomed
        "execute t:zoom_winrestcmd
        "let t:zoomed = 0
    "else
        "let t:zoom_winrestcmd = winrestcmd()
        "resize
        "vertical resize
        "let t:zoomed = 1
    "endif
"endfunction
"command! ZoomToggle call s:ZoomToggle()
