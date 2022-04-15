
function! file#prompt_rename(source)
    let newfilename = input('new filename: ', a:source)
    if len(newfilename) > 0 && newfilename !=# a:source
        execute "!mv \"" . a:source . "\" \"" . newfilename . "\""
    endif
endfunction

function! file#slashpath(path)
    " modify windows slashs to unix style
    return substitute(a:path, "/", "\\", "g")
endfunction

" for dirvish copypaths,
" use <cfile> instead of %
function s:d_expand(pattern) 
    if &filetype == 'dirvish'
        let toexp = substitute(a:pattern, "%", "<cfile>", "")
    else
        let toexp = a:pattern
    endif
    return expand(toexp)
endfunction

" platform specific file expands
" fixing slashs on windows
" prefer ~/home/relative on linux
function! file#ex_dir()
    " directory from current filename
    if has('mac')
        return expand("%:p:h")
    elseif has('win32')
        return file#slashpath(expand("%:p:h"))
    else 
        return expand("%:~:h")
    endif
endfunction

function! file#ex_full()
    " fullpath from current filename
    if has('mac')
        return s:d_expand("%:p")
    elseif has('win32')
        return file#slashpath(s:d_expand("%:p"))
    else 
        return s:d_expand("%:~")
    endif
endfunction

function! file#ex_filename()
    " filename from current filename
    if has('win32')
        return file#slashpath(s:d_expand("%:t"))
    else 
        return s:d_expand("%:t")
    endif
endfunction

function! file#ex_stem()
    " file stem from current filename
    if has('win32')
        return file#slashpath(s:d_expand("%:t:r"))
    else 
        return s:d_expand("%:t:r")
    endif
endfunction

function! file#clip(path, showmsg)
    " copy `path` to clibpboard
    " also put in "f register

    " some shells don't have clipboard, so 
    "   set g:clip to an external command
    let clip = get(g:, "clip", "")
    if clip != ""
        call system(clip, expand("%:p:h"))
    else
        let @+ = a:path
    endif

    let @f = a:path
    if a:showmsg != 0
        echo "copied"
    endif
endfunction

function! file#from_qf(line)
    " parse filename from quickfix line
    "  supporting:
    "  grep: path/to/filename.ext|3| 10:matched text
    "
    let pos = match(a:line, '|\d\+|')
    if pos != -1
        return strpart(a:line, 0, pos)
    endif

    return ""
endfunction

