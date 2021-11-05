set nocompatible
filetype plugin indent on
syntax enable 

let s:plug_vim = glob(has('nvim') ? '$XDG_CONFIG_HOME/nvim' : '$HOME/.vim') . '/autoload/plug.vim'
if !filereadable(s:plug_vim)
	  silent execute '!curl -fLo ' . s:plug_vim . ' --create-dirs ' 
          \ . 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
	  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
	endif
call plug#begin()
    Plug 'lambdalisue/fern.vim'
    Plug 'jupyter-vim/jupyter-vim'
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
    "Plug 'camspiers/animate.vim'
    Plug 'camspiers/lens.vim'
    Plug 'evanleck/vim-svelte', {'branch': 'main'}

    "Plug 'wellle/context.vim'
        "let g:context_nvim_no_redraw = 1
    "Plug 'raghur/vim-ghost', {'do': ':GhostInstall'}

	Plug 'junegunn/vim-slash'
    Plug 'junegunn/vim-after-object'
	Plug 'machakann/vim-highlightedyank'
	Plug 'michaeljsmith/vim-indent-object' 
    Plug 'unblevable/quick-scope'
        let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

	Plug 'luochen1990/rainbow' 
        let g:rainbow_active = 1
        let g:rainbow_conf = {
                    \    'separately': {
                    \        'typescript': 0
                    \    }
                    \}
    Plug 'junegunn/fzf' " Just  get the default shell bindings
    Plug 'junegunn/fzf.vim'
        nnoremap <silent><C-s> :GFiles -co --exclude-standard <CR>

    Plug 'antoinemadec/FixCursorHold.nvim'
        let g:cursorhold_updatetime = 100

	Plug 'neoclide/coc.nvim', {'branch': 'release'}
    let g:coc_start_at_startup = 1
    let g:coc_global_extensions = [
                \'coc-snippets',
                \'coc-tsserver',
                \'coc-eslint',
                \'coc-python',
                \'coc-omnisharp',
                \'coc-go',
                \'coc-rust-analyzer',
                \'coc-svelte'
                \]
                "\'coc-rls',
    if get(g:, 'coc_enabled', v:true)
        inoremap <silent><expr> <TAB>
              \ pumvisible() ? "\<C-n>" :
              \ <SID>check_back_space() ? "\<TAB>" :
              \ coc#refresh()
        inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

        function! s:check_back_space() abort
          let col = col('.') - 1
          return !col || getline('.')[col - 1]  =~# '\s'
        endfunction

        inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                                      \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

        nmap <silent> <leader>d <Plug>(coc-definition)
        nmap <silent> <leader>y <Plug>(coc-type-definition)
        nmap <silent> <leader>i <Plug>(coc-implementation)
        nmap <silent> <leader>r <Plug>(coc-references)
        nmap <silent> <leader>n <Plug>(coc-rename) 
        nmap <silent> <leader>a <Plug>(coc-codeaction)
        xmap <leader> <leader>a <Plug>(coc-codeaction-selected)
        nmap <silent> <leader>z <Plug>(coc-fix-current)
        inoremap <silent><expr> <c-space> coc#refresh()
        "nnoremap <leader>a :CocAction <CR>

        nnoremap <silent> K :call <SID>show_documentation()<CR>
        function! s:show_documentation()
            if (index(['vim','help'], &filetype) >= 0)
                execute 'h '.expand('<cword>')
            elseif (coc#rpc#ready())
                call CocActionAsync('doHover')
            else
                execute '!' . &keywordprg . " " . expand('<cword>')
            endif
        endfunction

        " Highlight the symbol and its references when holding the cursor.
        autocmd CursorHold * silent call CocActionAsync('highlight')
        set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
    endif

call plug#end()

"Colorscheme
colorscheme hashpunk-v3

"Mappings
map <SPACE> <leader>
nnoremap <leader><space> <Nop>
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
nnoremap <M-l> gt
nnoremap <M-h> gT

"Term
tnoremap <expr> <Esc> (&filetype == "fzf") ? "<Esc>" : "<c-\><c-n>"
tnoremap <C-J> <c-\><c-n><C-W><C-J>
tnoremap <C-K> <c-\><c-n><C-W><C-K>
tnoremap <C-L> <c-\><c-n><C-W><C-L>
tnoremap <C-H> <c-\><c-n><C-W><C-H>
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
