highlight clear

if exists('syntax_on')
  syntax reset
endif

let g:colors_name = 'hashpunk-sweet'
set background=dark

" Text style 
let s:clear =  ['NONE', 'NONE']
let s:italic      =   'italic'
let s:bold        =   'bold'
let s:underline   =   'underline'
let s:none        =   'NONE'

function! s:highlight(group, fg, bg, style)
  exec  "highlight "  . a:group
    \ . " ctermfg="   . a:fg[0]
    \ . " ctermbg="   . a:bg[0]
    \ . " cterm="     . a:style
    \ . " guifg="     . a:fg[1]
    \ . " guibg="     . a:bg[1]
    \ . " gui="       . a:style
endfunction

" Main colors
let s:Main = ['161', '#d7005f']
let s:MainLight = ['205', '#FF1C8D']
let s:MainDark = ['53', '#B5005A']

let s:Compl1 = ['42', '#00D778']
let s:Compl2 = ['76', '#61d700']

let s:Grey0 = ['231', '#ffffff']
let s:Grey1 = ['250', '#d7d7d7']
let s:Grey2 = ['248', '#a8a8a8']
let s:Grey3 = ['242', '#6c6c6c']

call s:highlight('Comment', s:Grey3, s:clear, s:italic)
call s:highlight('String', s:Grey0, s:clear, s:none)
call s:highlight('Constant', s:Grey2, s:clear, s:bold)
call s:highlight('Character', s:Grey2, s:clear, s:none)
call s:highlight('Number', s:Grey0, s:clear, s:none)      
call s:highlight('Boolean', s:MainLight, s:clear, s:none)
call s:highlight('Float', s:Grey0, s:clear, s:none)
call s:highlight('Folded', s:Grey3, s:clear, s:italic)

"fzf
call s:highlight('fzf1', s:Main, s:clear, s:none)
call s:highlight('fzf2', s:Main, s:clear, s:none)
call s:highlight('fzf3', s:Main, s:clear, s:none)

call s:highlight('Identifier', s:Main, s:clear, s:bold)
call s:highlight('Function', s:Main, s:clear, s:none)

call s:highlight('Statement', s:Grey2, s:clear, s:bold)
call s:highlight('Conditional', s:Main, s:clear, s:bold)
call s:highlight('Repeat', s:Main, s:clear, s:bold)
call s:highlight('Label', s:Main, s:clear, s:bold)       
call s:highlight('Operator', s:Main, s:clear, s:none)
call s:highlight('Keyword', s:MainLight, s:clear, s:none)
call s:highlight('Exception', s:Main, s:clear, s:italic)

call s:highlight('PreProc', s:Grey1, s:clear, s:italic)
call s:highlight('Include', s:Grey3, s:clear, s:italic)
call s:highlight('Define', s:Grey2, s:clear, s:italic)
call s:highlight('Macro', s:Grey2, s:clear, s:italic)
call s:highlight('PreCondit', s:Main, s:clear, s:italic)

call s:highlight('Type', s:Compl1, s:clear, s:bold)
call s:highlight('StorageClass', s:Compl1, s:clear, s:bold)
call s:highlight('Structure', s:Main, s:clear, s:bold)
call s:highlight('Typedef', s:Main, s:clear, s:bold)

call s:highlight('Special', s:Grey2, s:clear, s:none)
call s:highlight('SpecialChar', s:Main, s:clear, s:none)
call s:highlight('Delimiter', s:Main, s:clear, s:none)
call s:highlight('SpecialComment', s:Grey2, s:clear, s:none)
call s:highlight('Debug', s:Main, s:clear, s:none)
call s:highlight('Underlined', s:Grey2, s:clear, s:underline)
call s:highlight('Error', s:Main, s:clear, s:underline)
call s:highlight('Todo', s:Main, s:clear, s:none)

call s:highlight('Directory', s:Grey3, s:clear, s:none)
call s:highlight('CursorLine', s:Main, s:clear, s:bold)
call s:highlight('MatchParen', s:Grey0, s:MainLight, s:none)
call s:highlight('ColorColumn', s:Main, s:Grey1, s:none)

call s:highlight('Normal', s:Grey0, s:clear, s:none)
call s:highlight('Visual', s:clear, s:Grey1, s:none)
call s:highlight('Cursor', s:clear, s:Grey0, s:none)
call s:highlight('iCursor', s:clear, s:Grey0, s:none)
call s:highlight('LineNr', s:Grey2, s:clear, s:none)
call s:highlight('NonText', s:Grey2, s:clear, s:none)
if !has('nvim')
    call s:highlight('EndOfBuffer', s:Grey0, s:clear, s:none)
endif
call s:highlight('CursorLineNr', s:Main, s:clear, s:none)
call s:highlight('VertSplit', s:Grey1, s:clear, s:none)

" Pmenu
call s:highlight('Pmenu', s:Grey3, [16, '#090909'], s:none)
call s:highlight('PmenuSel', s:Main, [16, '#090909'], s:none)
call s:highlight('TabLineSel', s:Main, s:clear, s:italic)
call s:highlight('StatusLine', s:Grey3, s:clear, s:none)
call s:highlight('SignColumn', s:clear, s:clear, s:none)

" Search
call s:highlight('Search', s:Grey0, s:MainDark, s:none)

" GitDiff 
call s:highlight('DiffAdd', s:Main, s:Grey3, s:none)
call s:highlight('DiffChange', s:Grey1, s:Grey3, s:none)
call s:highlight('DiffText', s:Main, s:Grey2, s:none)
call s:highlight('DiffDelete', s:Grey0, s:Main, s:none)

"Coc
call s:highlight('CocHighlightText', s:Grey0, s:MainDark, s:bold)

" Python syntax highlighting
hi! link pythonStatement Statement
call s:highlight('pythonFunction', s:Main, s:clear, s:none)
call s:highlight('pythonBuiltin', s:Grey2, s:clear, s:italic)
call s:highlight('pythonStatement', s:Compl1, s:clear, s:bold)

" Typescript
call s:highlight('typescriptVariable', s:Compl1, s:clear, s:bold)
call s:highlight('typescriptAsyncFuncKeyword', s:Compl1, s:clear, s:bold)
call s:highlight('typescriptFuncKeyword', s:Compl1, s:clear, s:bold)
call s:highlight('typescriptGlobal', s:Grey2, s:clear, s:bold)
call s:highlight('typescriptMember', s:Grey1, s:clear, s:none)
call s:highlight('typescriptVariableDeclaration', s:Grey2, s:clear, s:none)
call s:highlight('typescriptIdentifier', s:Compl1, s:clear, s:none)

call s:highlight('typescriptObjectLiteral', s:Main, s:clear, s:bold)
call s:highlight('typescriptObjectLabel', s:Grey0, s:clear, s:none)


