set commentstring=%%%s

let b:switch_custom_definitions =
    \ [
    \   {
    \       '<<\("[^"]*"\)>>': '\1',
    \       '\("[^"]*"\)': '<<\1>>',
    \   }
    \ ]
