
function s:open_current() 
    let line = getline(".")
    let filename = file#from_qf(line)
    if filename != ""
        execute ":tabedit " . filename
    endif
endfunction

nmap <buffer> <c-t> :call <SID>open_current()<cr>
