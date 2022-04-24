
" function! s:map_toggle(key, opt)

" Map key to toggle opt (normal/insert)
function! toggle#add(key, opt)
    let cmd = ':set '.a:opt.'! \| set '.a:opt."?\<cr>"
    exec 'nnoremap '.a:key.' '.cmd
    exec 'inoremap '.a:key." \<C-O>".cmd
endfunction

" Toggle (+=|-=) value in `opt` list, in current buffer
" eg: iskeyword, guioptions etc
function! toggle#option_list(opt, value)
    let values = split(eval('&'.a:opt), ",")
    let present = index(values, a:value) != -1
    let op = (present) ? '-=' : '+='
    exec 'setlocal ' . a:opt . op . a:value
endfunction

" prompt for the character to add/remove from opt
function! toggle#option_list_prompt(opt)
    let c = getchar()
    if c =~ '^\d\+$'
        let c = nr2char(c)
    endif
    if match(c, '\e') != 0
        call toggle#option_list(a:opt, c)
    endif
endfunction

function! toggle#let_from(var, possible)
    let idx = 0
    let length = len(a:possible)
    while idx < length
        if a:possible[idx] == a:var
            let next = (idx == length-1) ? 0 : idx + 1
            return a:possible[next]
        endif
        let idx += 1
    endwhile

    " var not in `possible`
    return a:var
endfunction

function! toggle#quickfix()
    let ids = getqflist({'winid' : 1})
    if get(ids, "winid", 0) != 0
        cclose
    else
        botright copen
    endif
endfunction
