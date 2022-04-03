
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

" TODO:
"  function myexpand 
"   mac/wind -> %:p  ,  linux -> %:~
"   dirvish  -> ...

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
        return expand("%:p")
    elseif has('win32')
        return file#slashpath(expand("%:p"))
    else 
        return expand("%:~")
    endif
endfunction

function! file#ex_filename()
    " filename from current filename
    if has('win32')
        return file#slashpath(expand("%:t"))
    else 
        return expand("%:t")
    endif
endfunction

function! file#ex_stem()
    " file stem from current filename
    if has('win32')
        return file#slashpath(expand("%:t:r"))
    else 
        return expand("%:t:r")
    endif
endfunction

function! file#clip(content, showmsg)
    " copy content to clibpboard
    " also put in "f register
    let @+ = a:content
    let @f = a:content
    if a:showmsg != 0
        echo "copied"
    endif
endfunction
