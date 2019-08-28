
function! s:get_visual_selection()
    " Why is this not a built-in Vim script function?!
    let [line_start, column_start] = getpos("'<")[1:2]
    let [line_end, column_end] = getpos("'>")[1:2]
    let lines = getline(line_start, line_end)
    if len(lines) == 0
        return ''
    endif
    let lines[-1] = lines[-1][: column_end - (&selection ==# 'inclusive' ? 1 : 2)]
    let lines[0] = lines[0][column_start - 1:]
    return join(lines, "\n")
endfunction

function! ALEOpenRelative() abort
    let path = input('path: ')
    if path is# '' 
        return
    endif

    let alefile = tlib#file#Join(['~/.vim/bundle/ale', path])
    execute('edit ' . alefile)
endfunction

function! ALEReloadGitModified() abort
    call tlib#dir#Push('~/.vim/bundle/ale')
    try
        let filenames = systemlist('git status -s | grep "^\s*M" | cut -c4-')
        for filename in filenames
            if match(filename, '\.vim$') != -1
                echom 'reloading ' . filename
                execute(':so ' . filename)
            endif
        endfor
    finally
        call tlib#dir#Pop()
    endtry
endfunction

function! EvalCurrentLine(remove_prefixes) abort
    let currentline = getline('.')
    if match(currentline, '^\s*$') != -1
        return
    endif
    if a:remove_prefixes 
        let currentline = substitute(currentline, '[' . a:remove_prefixes . ']:', '', 'g')
    endif
    execute(currentline)
endfunction

function! EvalCurrentVisual(remove_prefixes) abort
    let lines = s:get_visual_selection()
    if lines is# ''
        return
    endif
    if a:remove_prefixes 
        let currentline = substitute(currentline, '[' . a:remove_prefixes . ']:', '', 'g')
    endif
    execute(lines)
endfunction

function! ReloadCurrentFile() abort
    if expand('%:e') is# 'vim'
        so %
    endif
endfunction

" shortcuts to reload
nnoremap <Leader>dx :call EvalCurrentLine('')<CR>
vnoremap <Leader>dx :call EvalCurrentVisual('')<CR>
nnoremap <Leader>dg :call EvalCurrentLine('g')<CR>
vnoremap <Leader>dg :call EvalCurrentVisual('g')<CR>
nnoremap <Leader>ds :call EvalCurrentLine('s')<CR>
vnoremap <Leader>ds :call EvalCurrentVisual('s')<CR>
nnoremap <Leader>db :call EvalCurrentLine('b')<CR>
vnoremap <Leader>db :call EvalCurrentVisual('b')<CR>
nnoremap <Leader>di :call EvalCurrentLine(input('[bglsa]'))<CR>
vnoremap <Leader>di :call EvalCurrentVisual(input('[bglsa]'))<CR>

" reload whole file
nnoremap <Leader>so :so %<CR>

" reload ALE
nnoremap <Leader>Ar :call ALEReloadGitModified()<CR>
nnoremap <Leader>Ao :call ALEOpenRelative()<CR>
