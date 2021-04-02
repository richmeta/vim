
function! file#prompt_rename(source)
    let newfilename = input('new filename: ', a:source)
    if len(newfilename) > 0 && newfilename !=# a:source
        execute "!mv \"" . a:source . "\" \"" . newfilename . "\""
    endif
endfunction
