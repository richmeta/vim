" Esc close dirvish buffer
nmap <buffer> <Esc> gq

" wd = cd (dirvish)
nmap <buffer> wd :execute 'cd ' . expand('%')<bar>:pwd<cr>

" pd = print directory name
nmap <buffer> pd :echo expand('%')<cr>

" md = mkdir (dirvish)
nmap <buffer> md :!mkdir %/

" cp = copy file under cursor (dirvish)
nmap <buffer> cp :!cp "<cfile>" 

" mv = move file under cursor (dirvish)
nmap <buffer> mv :!mv "<cfile>" 

" rm = delete file under cursor (dirvish)
nmap <buffer> rm :!rm -i "<cfile>" <cr>

" ne = new file
nmap <buffer> ne :e %/

" v = vertical split (dirvish)
" s = horiz split (dirvish)
nmap <buffer> v a
nmap <buffer> s o
nmap <buffer> <C-T> t

" open file under cursor in new tab (dirvish)
nnoremap <buffer> <silent> t :call dirvish#open('tabedit', 0)<cr>
xnoremap <buffer> <silent> t :call dirvish#open('tabedit', 0)<cr>

nmap <buffer><nowait><silent> <cr> :<C-U>call dirvish#open("edit", 0)<cr>:echo(expand('%'))<cr>

nnoremap <buffer> <Leader>P :execute 'Files! ' . expand('%:p')<cr>

" copypath
" \cd = copy directory/path
" \cf = copy fullpath
" \cv = copy filename only
" \cs = copy stem
if has('win32')
    " prefer with windows path backslash
    nmap <buffer> <Leader>cf :let @+=substitute(expand("<cfile>"), "/", "\\", "g")<cr>
    nmap <buffer> <Leader>cv :let @+=substitute(fnamemodify(expand("<cfile>"), ":t"), "/", "\\", "g")<cr>
    nmap <buffer> <Leader>cs :let @+=substitute(fnamemodify(expand("<cfile>"), ":t:r"), "/", "\\", "g")<cr>
elseif has('unix')
    nmap <buffer> <Leader>cf :let @+=expand("<cfile>")<cr>
    nmap <buffer> <Leader>cv :let @+=fnamemodify(expand("<cfile>"), ":t")<cr>
    nmap <buffer> <Leader>cs :let @+=fnamemodify(expand("<cfile>"), ":t:r")<cr>
endif

