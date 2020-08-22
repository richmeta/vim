
" operatorfunc for g@
function! SingleQuote(type)
    call s:add_quotes(a:type, "'", 0)
endfunction

function! DoubleQuote(type)
    call s:add_quotes(a:type, '"', 0)
endfunction

function! SingleQuoteComma(type)
    call s:add_quotes(a:type, "'", 1)
endfunction

function! DoubleQuoteComma(type)
    call s:add_quotes(a:type, '"', 1)
endfunction

function! RemoveQuote(type)
    call s:remove_quotes(a:type)
endfunction

function! AddComma(type)
    call s:add_commas(a:type)
endfunction

function! RemoveComma(type)
    call s:remove_commas(a:type)
endfunction

function! s:charwise_replace(pattern, string)
    " '[,']s - doesn't work because affects whole line
    " nor does column anchors  \%23c  or \%']
    let current = getline("'[")
    let lpos = col("'[")-1
    let rpos = col("']")-1
    let substr = current[lpos:rpos]
    let quoted = substitute(substr, a:pattern, a:string, 'g')

    if lpos == 0
        let newline = quoted . current[rpos+1:]
    else
        let newline = current[0:lpos-1] . quoted . current[rpos+1:]
    endif
    call setline("'[", newline)
endfunction

function! s:add_quotes(type, quote_char, commas)
    " type = 'char/line/block'
    " quote_char = ' or "
    " comma = 0 or 1
    let replace = a:quote_char . '\1' . a:quote_char . (a:commas ? "," : "")
    
    if a:type == 'line'
        exec "'[,']s/\\v(\\w+)[,]*/" . replace . '/g'
    elseif a:type == 'char'
        call s:charwise_replace('\v(\w+)[,]*', replace)
    elseif a:type == 'block'
        exec "'<,'>s/\\v(\\w+)[,]*/" . replace . '/g'
    endif
endfunction

function! s:remove_quotes(type)
    if a:type == 'line'
        exec "'[,']s/['\"]//g"
    elseif a:type == 'char'
        " be careful to use W since w won't match endquote
        call s:charwise_replace("['\"]", "")
    elseif a:type == 'block'
        exec "'<,'>s/['\"]//g"
    endif
endfunction

function! s:add_commas(type)
    if a:type == 'line'
        exec "'[,']s/\\v(\\w+)[,]*/\\1,/g"
    elseif a:type == 'char'
        call s:charwise_replace('\v(\w+)[,]*', '\1,')
    elseif a:type == 'block'
        exec "'<,'>s/\\v(\\w+)[,]*/\\1,/g"
    endif
endfunction

function! s:remove_commas(type)
    if a:type == 'line'
        exec "'[,']s/,//g"
    elseif a:type == 'char'
        " be careful to use W since w won't match endquote
        call s:charwise_replace(",", "")
    elseif a:type == 'block'
        exec "'<,'>s/,//g"
    endif
endfunction
