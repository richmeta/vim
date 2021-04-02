
function! buff#is_empty(buf)
    let res = getbufline(a:buf, 1)
    return res == ['']
endfunction

function! buff#find_first_empty()
    for i in range(1, bufnr('$'))
        let name = bufname(i)
        if name == "" && buff#is_empty(i)
            return i
        endif
    endfor
    return -1
endfunction

function! buff#find_tab_for_buffer(buf)
    for i in range(tabpagenr('$'))
        let buflist = tabpagebuflist(i + 1)
        let found = index(buflist, a:buf)
        if found != -1 
            return i + 1
        end
    endfor
    return -1
endfunction

