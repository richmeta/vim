
setlocal tabstop=4
setlocal shiftwidth=4

" 1 - kwargs and dict  {'key': 'value'} => {key='value'}
" 2 - kwargs and dict  {key='value'}    => {'key': 'value'}
" 3 - import \k+ => from \k import
" 4 - from \k import => import \k+
let b:switch_custom_definitions =
    \ [
    \   {
    \       '\(\k\+\)=\([^),]\+\)': '''\1'': \2',
    \       '[''"]\(\k\+\)[''"]:\s*\([^},]\+\)': '\1=\2',
    \       'import\s\+\(\k\+\)': 'from \1 import ',
    \       'from\s\+\(\k\+\)\s\+import\s.*$': 'import \1',
    \   }
    \ ]

