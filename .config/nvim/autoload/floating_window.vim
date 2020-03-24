let s:floating_win = {}

augroup Compile_commands
    autocmd! 
    autocmd FileType java nnoremap <silent> <F5> :call floating_window#CompileJava()<CR>
augroup END

function! floating_window#CompileJava()
    let l:proj_root = Get_project_root()
    let l:command = ""

    if !empty(l:proj_root) && filereadable(l:proj_root . '/pom.xml')
        let l:command = systemlist('(cd '.l:proj_root.';mvn compile exec:java -q)')
    else
        let l:command = systemlist('java '. expand('%'))
    endif
    call floating_window#OpenFloatingWindow(l:command)
endfunction

function! s:max_str_width(strlist)
    let l:max = 0
    for str in a:strlist
        let l:width = nvim_strwidth(str)
        if l:width > l:max
            let l:max = l:width
        endif
    endfor
    return l:max
endfunction

function! floating_window#OpenFloatingWindow(string) 
    let l:str_list = a:string
    if type(a:string) == v:t_string 
        let l:str_list = split(a:string, '\n')
    endif

    let l:buf_id = nvim_create_buf(v:false, v:false)
    let l:max_width = s:max_str_width(l:str_list)
    if l:max_width == 0
        echom 'Empty response'
        return
    endif

    call nvim_buf_set_lines(l:buf_id, 0, len(l:str_list), v:false, l:str_list)
    let l:win_id = nvim_open_win(l:buf_id, v:false, { 
                \'relative': 'cursor',
                \'width': l:max_width,
                \'height': len(l:str_list),
                \'bufpos': [-1, 0],
                \'row': 1,
                \'style': 'minimal',
                \'focusable': v:true
                \})

    let s:floating_win = {
                \'win_id': l:win_id,
                \'buf_id': l:buf_id
                \}
endfunction

function s:on_cursor_move()
    if !empty(s:floating_win)
        call nvim_win_close(s:floating_win['win_id'], v:true)
        call nvim_command('bwipeout!'. s:floating_win['buf_id'])
        let s:floating_win = {}
    endif
endfunction

augroup compile_au_cmd
    autocmd!
    autocmd CursorMoved,CursorMovedI * call s:on_cursor_move()
augroup END
