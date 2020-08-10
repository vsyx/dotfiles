highlight clear

if exists('syntax_on')
  syntax reset
endif

let g:colors_name = 'hashpunk-sweet'
set background=dark

" Dark Meadow Legacy
let s:clear           =  ['NONE', 'NONE'   ]
let s:DarkMagenta     =  ['90'  , '#870087']
let s:Purple4         =  ['55'  , '#5f00af']
let s:SkyBlue1        =  ['117' , '#87afff']
let s:Magenta2        =  ['165' , '#d700ff']
let s:MediumOrchid1   =  ['207' , '#ff5faf']

" Hashpunk
let s:MainColor = ['161', '#d7005f']
let s:ComplementaryColor = ['162', '#d70087']

let s:Grey0 = ['16', '#000000']
let s:Grey7 = ['233', '#121212']
let s:Grey15 = ['235', '#262626']
let s:Grey19 = ['236', '#303030']
let s:Grey42 = ['242', '#6c6c6c']
let s:Grey54 = ['245', '#505050']
let s:Grey66 = ['248', '#a8a8a8']
let s:Grey74 = ['250', '#bcbcbc']
let s:Grey93 = ['255', '#eeeeee']

" Text style 
let s:italic      =   'italic'
let s:bold        =   'bold'
let s:underline   =   'underline'
let s:none        =   'NONE'

" Helper function to set up highlight executions
function! s:highlight(group, fg, bg, style)
  exec  "highlight "  . a:group
    \ . " ctermfg="   . a:fg[0]
    \ . " ctermbg="   . a:bg[0]
    \ . " cterm="     . a:style
    \ . " guifg="     . a:fg[1]
    \ . " guibg="     . a:bg[1]
    \ . " gui="       . a:style
endfunction

" Syntax highlighting groups
"
" For reference on what each group does, please refer to this:
" vimdoc.sourceforge.net/htmldoc/syntax.html
"
call s:highlight('StatusLine', s:Grey93, s:clear, s:none)

call s:highlight('markdownItalic', s:Grey93, s:clear, s:italic)
call s:highlight('markdownCode', s:MainColor, s:clear, s:none)
call s:highlight('markdownCodeBlock', s:MainColor, s:clear, s:none)
call s:highlight('markdownCodeDelimiter', s:MainColor, s:clear, s:none)
call s:highlight('netrwClassify', s:Grey66, s:clear, s:none)

call s:highlight('fzf1', s:MainColor, s:clear, s:none)
call s:highlight('fzf2', s:MainColor, s:clear, s:none)
call s:highlight('fzf3', s:MainColor, s:clear, s:none)

call s:highlight('Comment', s:Grey42, s:clear, s:italic)
call s:highlight('Constant', s:MainColor, s:clear, s:none)
call s:highlight('String', s:Grey93, s:clear, s:none)
call s:highlight('Character', s:Grey93, s:clear, s:none)
call s:highlight('Number', s:Grey93, s:clear, s:none)      
call s:highlight('Boolean', s:ComplementaryColor, s:clear, s:none)
call s:highlight('Float', s:MainColor, s:clear, s:none)
call s:highlight('Folded', s:Grey93, s:clear, s:italic)

call s:highlight('Identifier', s:MainColor, s:clear, s:none)
call s:highlight('Function', s:MainColor, s:clear, s:none)

call s:highlight('Statement', s:MainColor, s:clear, s:bold)
call s:highlight('Conditional', s:MainColor, s:clear, s:bold)
call s:highlight('Repeat', s:MainColor, s:clear, s:bold)
call s:highlight('Label', s:MainColor, s:clear, s:bold)       
call s:highlight('Operator', s:MainColor, s:clear, s:none)
call s:highlight('Keyword', s:MainColor, s:clear, s:none)
call s:highlight('Exception', s:MainColor, s:clear, s:italic)

call s:highlight('PreProc', s:Grey54, s:clear, s:italic)
call s:highlight('Include', s:Grey74, s:clear, s:italic)
call s:highlight('Define', s:Grey66, s:clear, s:italic)
call s:highlight('Macro', s:Grey66, s:clear, s:italic)
call s:highlight('PreCondit', s:MainColor, s:clear, s:italic)

call s:highlight('Type', s:MainColor, s:clear, s:bold)
call s:highlight('StorageClass', s:MainColor, s:clear, s:bold)
call s:highlight('Structure', s:MainColor, s:clear, s:bold)
call s:highlight('Typedef', s:MainColor, s:clear, s:bold)

call s:highlight('Special', s:Grey66, s:clear, s:none)
call s:highlight('SpecialChar', s:MainColor, s:clear, s:none)
call s:highlight('Delimiter', s:MainColor, s:clear, s:none)
call s:highlight('SpecialComment', s:Grey54, s:clear, s:none)
call s:highlight('Debug', s:MainColor, s:clear, s:none)
call s:highlight('Underlined', s:Grey54, s:clear, s:underline)
call s:highlight('Error', s:MainColor, s:clear, s:underline)
call s:highlight('Todo', s:MainColor, s:clear, s:none)

call s:highlight('Directory', s:Grey66, s:clear, s:none)
call s:highlight('CursorLine', s:MainColor, s:clear, s:bold)
call s:highlight('MatchParen', s:Grey0, s:MediumOrchid1, s:none)
call s:highlight('ColorColumn', s:MainColor, s:Grey15, s:none)

" Interface highlighting
call s:highlight('Normal', s:Grey93, s:Grey0, s:none)
call s:highlight('Visual', s:clear, s:Grey15, s:none)
call s:highlight('Cursor', s:clear, s:Grey0, s:none)
call s:highlight('iCursor', s:clear, s:Grey0, s:none)
call s:highlight('LineNr', s:Grey66, s:clear, s:none)
call s:highlight('NonText', s:Grey66, s:clear, s:none)
call s:highlight('CursorLineNr', s:MainColor, s:clear, s:none)
call s:highlight('VertSplit', s:Grey15, s:clear, s:none)

" Pmenu
call s:highlight('Pmenu', s:Grey93, [16, '#090909'], s:none)
call s:highlight('PmenuSel', s:MainColor, [16, '#090909'], s:none)
call s:highlight('TabLineSel', s:MainColor, s:clear, s:italic)

" Search
call s:highlight('Search', s:Grey93, s:MainColor, s:none)

" GitDiff 
call s:highlight('DiffAdd', s:MainColor, s:Grey93, s:none)
call s:highlight('DiffChange', s:Grey7, s:Grey93, s:none)
call s:highlight('DiffText', s:MainColor, s:Grey74, s:none)
call s:highlight('DiffDelete', s:Grey0, s:MainColor, s:none)

" Git Gutter
call s:highlight('GitGutterAdd', s:Grey93, s:clear, s:none)
call s:highlight('GitGutterChange', s:Grey93, s:clear, s:none)
call s:highlight('GitGutterDelete', s:Grey93, s:clear, s:none)
call s:highlight('GitGutterChangeDelete', s:Grey93, s:clear, s:none)
call s:highlight('SignColumn', s:Grey93, s:clear, s:none)


" Java syntax highlighting
call s:highlight('javaParen', s:MainColor, s:clear, s:none)
call s:highlight('javaCommentTitle', s:Grey42, s:clear, s:none)
call s:highlight('javaDocParam', s:MainColor, s:clear, s:none)
call s:highlight('javaDocTags', s:Grey54, s:clear, s:none)
call s:highlight('javaScopeDecl', s:Grey54, s:clear, s:none)
call s:highlight('javaStorageClass', s:MainColor, s:clear, s:none)


" Python syntax highlighting
call s:highlight('pythonFunction', s:Grey93, s:clear, s:none)
call s:highlight('pythonBuiltin', s:Grey54, s:clear, s:italic)


" Vimscript syntax highlighting
call s:highlight('vimOption', s:Grey93, s:clear, s:none)


" NERDTree
call s:highlight('NERDTreeClosable', s:MainColor, s:clear, s:none)
call s:highlight('NERDTreeOpenable', s:MainColor, s:clear, s:none)

" *NOTE*
"
" The following groups are plug specific and would require the following plugs
" from github in order for the groups to work.
"

" Elm syntax highlighting
" Requires plug: ElmCast/Magenta2-vim
"
call s:highlight('Magenta2TypeDef', s:MediumOrchid1, s:clear, s:bold)
call s:highlight('Magenta2Alias', s:Grey66, s:clear, s:none)
call s:highlight('Magenta2TopLevelDecl', s:SkyBlue1, s:clear, s:bold)
call s:highlight('Magenta2Braces', s:DarkMagenta, s:clear, s:none)


" Elixir syntax highlighting
" Requires plug: elixir-editors/vim-elixir
"
call s:highlight('elixirAlias', s:Magenta2, s:clear, s:italic)
call s:highlight('elixirDefine', s:MediumOrchid1, s:clear, s:none)
call s:highlight('elixirBlockDefinition', s:MediumOrchid1, s:clear, s:none)
call s:highlight('elixirFunctionDeclaration', s:Grey66, s:clear, s:none)


" GOLang syntax highlighting
" Requires plug: fatih/vim-go
"
call s:highlight('goPackage', s:Magenta2, s:clear, s:italic)
call s:highlight('goImport', s:Purple4, s:clear, s:italic)


" Rust syntax highlighting
" Requires plug: rust-lang/rust.vim
"
call s:highlight('rustMacro', s:MediumOrchid1, s:clear, s:none)

let g:terminal_color_0 = '#263640'
let g:terminal_color_1 = '#d12f2c'
let g:terminal_color_2 = '#819400'
let g:terminal_color_3 = '#b08500'
let g:terminal_color_4 = '#2587cc'
let g:terminal_color_5 = '#d7005f'
let g:terminal_color_6 = '#289c93'
let g:terminal_color_7 = '#a0a0a0'
let g:terminal_color_8 = '#4a697d'
let g:terminal_color_9 = '#fa3935'
let g:terminal_color_10 = '#a4bd00'
let g:terminal_color_11 = '#d9a400'
let g:terminal_color_12 = '#2ca2f5'
let g:terminal_color_13 = '#d7005f'
let g:terminal_color_14 = '#33c5ba'
let g:terminal_color_15 = '#ffffff'
