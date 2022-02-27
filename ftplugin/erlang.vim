setlocal commentstring=%%%s
setlocal indentexpr=""

" order:
" 1 - binary to string
" 2 - string to binary
" 3 - underscore Variable
" 4 - remove underscore Variable
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
    \   }
    \ ]


" \kd = toggle ':' in iskeyword
map <buffer> <Leader>kd :call ToggleOptionList('iskeyword', ':')<cr>

" \kc = search for handle_call under cursor
" nnoremap <buffer> <Leader>kc :keepjumps execute '/handle_call(.*' . expand("<cword>")<cr>

" \kc = search for handle_cast/call/info under cursor
nnoremap <buffer> <Leader>kc :keepjumps execute '/handle_[castlinfo]\{4}\s*(.*' . expand("<cword>")<cr>

" Ctrl \] = goto tag (overrides global for vim_erlang_tags)
nnoremap <buffer> <Leader><C-]> :call vim_erlang_tags#VimErlangTagsSelect(1)<cr><c-]><C-w>T

" \dp = delete ct:pal
nnoremap <buffer> <Leader>dp :%g/ct:pal\(\)/d<cr>

" \cp = copy module/function under cursor
nmap <Leader>cp :let @+=expand("%:t:r") . ":" . expand("<cword>")<cr>

