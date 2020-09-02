setlocal commentstring=%%%s

let b:switch_custom_definitions =
    \ [
    \   {
    \       '<<\("[^"]*"\)>>': '\1',
    \       '\("[^"]*"\)': '<<\1>>',
    \   }
    \ ]

" \kd - toggle ':' in iskeyword
map <buffer> <Leader>kd :call ToggleOptionList('iskeyword', ':')<cr>
