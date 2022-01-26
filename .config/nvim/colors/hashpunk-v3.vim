" Name:         dark-meadow 
" Author:       jliu2179/cliuj
" Maintainer:   jliu2179/cliuj
" License:      MIT

highlight clear

if exists('syntax_on')
  syntax reset
endif

let g:colors_name = 'hashpunk-v3'
set background=dark

" Color palette
"#c71585
let s:DeepPink1         =  ['198',  '#d7005f']
let s:LightDeepPink1    =  ['198',  '#FF1C8D']
let s:DarkDeepPink1     =  ['53', '#e22d87']
let s:HotPink           =  ['199',  '#ff00ff']
let s:clear             =  ['NONE', 'NONE']
let s:White             =  ['231',  '#ffffff']
let s:Red               =  ['9',    '#ff0000']
let s:DeepSkyBlue3      =  ['31',   '#0087af']
let s:SpringGreen3      =  ['35',   '#00ff87']
let s:BrightGreen       =  ['76',   '#61d700']
let s:DeepPink4         =  ['89',   '#87005f']
let s:SkyBlue1          =  ['117',  '#87afff']
let s:MediumVioletRed   =  ['126',  '#af0087']
let s:MediumOrchid1     =  ['171',  '#d75fff']
let s:Thistle1          =  ['225',  '#ffd7ff']
"unused
let s:MistyRose1        =  ['224',  '#ffd7ff']
let s:Grey1 = ['250', '#d7d7d7']
let s:Grey2             =  ['248',  '#a8a8a8']
let s:Grey3 = ['242', '#6c6c6c']
let s:Grey11            =  ['232',  '#1c1c1c']
let s:Grey42            =  ['235',  '#262626']
let s:Grey54            =  ['245',  '#8a8a8a']

" Text style 
let s:italic      =   'italic'
let s:bold        =   'bold'
let s:underline   =   'underline'
let s:none        =   'NONE'

" Helpec function to set up highlight executions
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
call s:highlight('Comment',         s:Grey54,           s:clear,    s:italic)
call s:highlight('Constant',        s:Grey1,     s:clear,    s:bold)
call s:highlight('String',          s:White,            s:clear,    s:none)
call s:highlight('Character',       s:SpringGreen3,     s:clear,    s:none)
call s:highlight('Number',          s:White,         s:clear,    s:none)
call s:highlight('Boolean',         s:LightDeepPink1,     s:clear,    s:none)
call s:highlight('Float',           s:White,         s:clear,    s:none)
call s:highlight('Folded',          s:Grey1,         s:clear,        s:italic)

call s:highlight('Identifier',      s:DeepPink1,         s:clear,    s:bold)
call s:highlight('Function',        s:DeepPink1,        s:clear,    s:bold)
call s:highlight('Statement',       s:Grey2,     s:clear,    s:bold)
call s:highlight('Conditional',     s:LightDeepPink1,        s:clear,    s:bold)
call s:highlight('Repeat',          s:DeepPink1,    s:clear,    s:bold)
call s:highlight('Label',           s:SpringGreen3,        s:clear,    s:bold)
call s:highlight('Operator',        s:BrightGreen,        s:clear,    s:bold)
call s:highlight('Keyword',         s:DarkDeepPink1,     s:clear,    s:bold)
call s:highlight('Exception',       s:SpringGreen3,     s:clear,    s:bold)
call s:highlight('PreProc',         s:Grey1,         s:clear,    s:italic)
call s:highlight('Include',         s:Grey2,        s:clear,    s:bold)
call s:highlight('Define',          s:DarkDeepPink1,    s:clear,    s:none)
call s:highlight('Macro',           s:DeepPink4,        s:clear,    s:none)
call s:highlight('PreCondit',       s:Grey3,         s:clear,    s:italic)
call s:highlight('Type',            s:DeepPink1,    s:clear,    s:italic)
call s:highlight('StorageClass',    s:SpringGreen3,  s:clear,    s:bold)
call s:highlight('Structure',       s:SpringGreen3,    s:clear,    s:bold)
call s:highlight('Typedef',         s:DeepPink1,  s:clear,    s:bold)
call s:highlight('Special',         s:Grey2,    s:clear,    s:bold)
call s:highlight('SpecialChar',     s:DeepPink1,    s:clear,    s:bold)
call s:highlight('Tag',             s:HotPink,     s:clear,    s:none)
call s:highlight('Delimiter',       s:DeepPink1,  s:clear,    s:none)
call s:highlight('SpecialComment',  s:Grey54,           s:clear,    s:none)
call s:highlight('Debug',           s:DeepPink1,              s:clear,    s:none)
call s:highlight('Underlined',      s:Grey2,         s:clear,    s:bold)
call s:highlight('Ignore',          s:Grey54,           s:clear,    s:none)
call s:highlight('Error',           s:DeepPink1,              s:clear,    s:bold)
call s:highlight('Todo',            s:DarkDeepPink1,    s:clear,    s:bold)

call s:highlight('Directory', s:Grey3, s:clear, s:none)
call s:highlight('CursorLine', s:DeepPink1, s:clear, s:bold)
call s:highlight('MatchParen', s:White, s:Grey3, s:none)
call s:highlight('ColorColumn', s:DeepPink1, s:Grey1, s:none)

" Interface highlighting
call s:highlight('Normal',          s:White,            s:clear,   s:none)
call s:highlight('Visual',          s:clear,            s:Grey3,   s:none)
call s:highlight('Cursor',          s:Thistle1,         s:clear,    s:none)
call s:highlight('iCursor',         s:Thistle1,         s:clear,    s:none)
call s:highlight('LineNr',          s:White,            s:clear,    s:none)
call s:highlight('CursorLineNr',    s:DeepPink1,        s:clear,    s:italic)
if !has('nvim')
    call s:highlight('EndOfBuffer', s:Grey0, s:clear, s:none)
endif
call s:highlight('CursorLineNr', s:DeepPink1, s:clear, s:none)
call s:highlight('VertSplit', s:Grey1, s:clear, s:none)

" Pmenu
call s:highlight('Pmenu', s:Grey3, [16, '#090909'], s:none)
call s:highlight('PmenuSel', s:DeepPink1, [16, '#090909'], s:none)
call s:highlight('SignColumn', s:clear, s:clear, s:none)

call s:highlight('StatusLine', s:White, s:clear, s:bold)
call s:highlight('StatusLineNC', s:Grey3, s:clear, s:none)

call s:highlight('Tabline', s:Grey3, s:clear, s:bold)

call s:highlight('TabLineSel', s:White, s:clear, s:none)
call s:highlight('TabLineFill', s:Grey3, s:clear, s:none)

" Search
call s:highlight('Search', s:White, s:DarkDeepPink1, s:none)

" GitDiff 
call s:highlight('DiffAdd', s:BrightGreen, s:Grey42, s:none)
call s:highlight('DiffChange', s:Grey1, s:Grey42, s:none)
call s:highlight('DiffText', s:DeepPink1, s:Grey42, s:none)
call s:highlight('DiffDelete', s:clear, s:DeepPink1, s:none)

"fzf
call s:highlight('fzf1', s:DeepPink1, s:clear, s:none)
call s:highlight('fzf2', s:DeepPink1, s:clear, s:none)
call s:highlight('fzf3', s:DeepPink1, s:clear, s:none)

"Coc
call s:highlight('CocHighlightText', s:White, s:DarkDeepPink1, s:bold)

"Barbar
call s:highlight('BufferCurrent', s:White, s:clear, s:bold)
call s:highlight('BufferCurrentSign', s:DeepPink1, s:clear, s:none)
call s:highlight('BufferInactiveSign', s:Grey42, s:clear, s:none)

"Status/ruler format
call s:highlight('User0', s:clear, s:clear, s:bold)
call s:highlight('User1', s:clear, s:DeepPink1, s:bold)
