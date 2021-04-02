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
