setlocal commentstring=%%%s

let b:switch_custom_definitions =
    \ [
    \   {
    \       '<<\("[^"]*"\)>>': '\1',
    \       '\("[^"]*"\)': '<<\1>>',
    \       '\<\(\u\w\+\)\>': '_\1',
    \       '\<_\(\u\w\+\)\>': '\1',
    \   }
    \ ]

" \kd - toggle ':' in iskeyword
map <buffer> <Leader>kd :call ToggleOptionList('iskeyword', ':')<cr>

" \kc - search for handle_call under cursor
nnoremap <buffer> <Leader>kc :keepjumps execute '/handle_call(\s*{' . expand("<cword>")<cr>

" \ka - search for handle_cast under cursor
nnoremap <buffer> <Leader>ka :keepjumps execute '/handle_cast(\s*{' . expand("<cword>")<cr>
