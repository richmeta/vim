" Esc close dirvish buffer
nmap <buffer> <Esc> gq

" wd = cd (dirvish)
nmap <buffer> wd :execute 'cd ' . expand('%')<bar>:pwd<CR>

" md = mkdir (dirvish)
nmap <buffer> md :!mkdir %/

" cp = copy file under cursor (dirvish)
nmap <buffer> cp :!cp "<cfile>" 

" mv = move file under cursor (dirvish)
nmap <buffer> mv :!mv "<cfile>" 

" rm = delete file under cursor (dirvish)
nmap <buffer> rm :!rm -i "<cfile>" <CR>

" ne = new file
nmap <buffer> ne :e %/

" v = vertical split (dirvish)
" s = horiz split (dirvish)
nmap <buffer> v a
nmap <buffer> s o
nmap <buffer> <C-T> t

" open file under cursor in new tab (dirvish)
nnoremap <buffer> <silent> t :call dirvish#open('tabedit', 0)<CR>
xnoremap <buffer> <silent> t :call dirvish#open('tabedit', 0)<CR>

nmap <buffer><nowait><silent> <CR> :<C-U>call dirvish#open("edit", 0)<CR>:echo(expand('%'))<CR>

nnoremap <buffer> <Leader>P :execute 'Files! ' . expand('%:p')<CR>
