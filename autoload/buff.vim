
function! buff#is_empty(buf)
    let res = getbufline(a:buf, 1)
    return res == ['']
endfunction

function! buff#open_relative(how)
    " how - [tvh ] => tab/vsplit/hsplit/normal
    let buffdir = expand("%:p:h")
    if (a:how == 'h') 
        let cmd = ":split"
    elseif (a:how == 'v')
        let cmd = ":vsplit"
    elseif (a:how == 't')
        let cmd = ":tabedit"
    else
        let cmd = ":edit"
    endif
    let cmd .= " " . buffdir . "/"
    call feedkeys(cmd)
endfunction

