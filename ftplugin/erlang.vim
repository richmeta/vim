setlocal commentstring=%%%s

" order:
" 1 - binary to string
" 2 - string to binary
" 3 - underscore Variable
" 4 - remove underscore Variable
" 5 - {atom, Var} to Var

"
" notes:  \@<! is positive lookbehind,
"         so #3 or 4 only matches when not preceded with quotes
"
let b:switch_custom_definitions =
    \ [
    \   {
    \       '<<"[^"]*">>': {
    \          '[<>]': ''
    \       },
    \       '"[^"]*"': {
    \          '\("[^"]*"\)': '<<\1>>'
    \       },
    \       '"\@<!\<\(\u\w*\)\>': '_\1',
    \       '"\@<!\<_\(\u\w*\)\>': '\1',
    \       '=>': ':=',
    \       ':=': '=>',
    \       'list_to_binary': 'binary_to_list',
    \       'binary_to_list': 'list_to_binary',
    \       'int_to_binary': 'binary_to_int',
    \       'binary_to_int': 'int_to_binary',
    \   }
    \ ]

" not sure if this is effective
"    \       '{\s*\l\+,\s*\(\u(\u\|\l)*\)\s*}': '\1',

" \kd = toggle ':' in iskeyword
map <buffer> <Leader>kd :call ToggleOptionList('iskeyword', ':')<cr>

" \kc = search for handle_cast/call/info/continue under cursor
nnoremap <buffer> <Leader>kc :keepjumps execute '/handle_[castlinfotue]\+\s*(.*' . expand("<cword>")<cr>

" Ctrl \] = goto tag (overrides global for vim_erlang_tags)
nnoremap <buffer> <Leader><C-]> :call vim_erlang_tags#VimErlangTagsSelect(1)<cr><c-]><C-w>T

" \dp = delete ct:pal
nnoremap <buffer> <Leader>dp :%g/ct:pal\(\)/d<cr>

" \cp = copy module/function under cursor
nmap <Leader>cp :let @+=expand("%:t:r") . ":" . expand("<cword>")<cr>

" \cr = copy redbug:start for module/function under cursor
" eg: redbug:start("carshare_server_handler_worker:do_poll -> return", [{time, 300000}]).
nmap <Leader>cr :let @+= 'redbug:start("' . expand("%:t:r") . ":" . expand("<cword>") . ' -> return", [{time, 300000}]).'<cr>

