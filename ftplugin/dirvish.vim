" Esc close dirvish buffer
nmap <buffer> <Esc> gq

" wd = cd (dirvish)
nmap <buffer> wd :execute 'cd ' . expand('%')<bar>:pwd<cr>

" \pd = print directory name
nmap <buffer> <leader>pd :echo expand('%')<cr>

" md = mkdir (dirvish)
nmap <buffer> md :!mkdir %/

" rd = rmdir (dirvish)
nmap <buffer> rd :execute '!rmdir ' . expand("<cfile>")<cr>

" cp = copy file under cursor (dirvish)
nmap <buffer> cp :!cp "<cfile>"<space>

" mv = move file under cursor (dirvish)
nmap <buffer> mv :!mv "<cfile>"<space>

" cw = rename file
nmap <buffer> cw :call file#prompt_rename(expand("<cfile>"))<cr>
nmap <buffer> rn cw

" rm = delete file under cursor (dirvish)
nmap <buffer> rm :!rm -i "<cfile>" <cr>
nmap <buffer> <Leader>rm rm

" ne = new file
nmap <buffer> ne :e %/

" v = vertical split (dirvish)
nmap <buffer> v a

" s = horiz split (dirvish)
nmap <buffer> s o

" ctrl-t = open in tab (dirvish)
nmap <buffer> <C-T> t

" open file under cursor in new tab (dirvish)
nnoremap <buffer> <silent> t :call dirvish#open('tabedit', 0)<cr>
xnoremap <buffer> <silent> t :call dirvish#open('tabedit', 0)<cr>

nmap <buffer><nowait><silent> <cr> :<C-U>call dirvish#open("edit", 0)<cr>:echo(expand('%'))<cr>

nnoremap <buffer> <Leader>P :execute 'CtrlP ' . expand('%:p')<cr>

nmap <buffer> <silent> h <Plug>(dirvish_up)
nmap <buffer> <silent> l :<C-U>call dirvish#open("edit", 0)<cr>:echo(expand('%'))<cr>

" copypath
" \cd = copy directory/path (and "f)
" \cf = copy fullpath (and "f)
" \cv = copy filename only (and "f)
" \cs = copy stem (and "f)
if has('win32')
    " prefer with windows path backslash
    nmap <buffer> <Leader>cd :let @+=substitute(expand("%"), "/", "\\", "g")<bar>let @f=@+<cr>
    nmap <buffer> <Leader>cf :let @+=substitute(expand("<cfile>"), "/", "\\", "g")<bar>let @f=@+<cr>
    nmap <buffer> <Leader>cv :let @+=substitute(fnamemodify(expand("<cfile>"), ":t"), "/", "\\", "g")<bar>let @f=@+<cr>
    nmap <buffer> <Leader>cs :let @+=substitute(fnamemodify(expand("<cfile>"), ":t:r"), "/", "\\", "g")<bar>let @f=@+<cr>
elseif has('unix')
    nmap <buffer> <Leader>cd :let @+=expand("%:~")<bar>let @f=@+<cr>                              " directory
    nmap <buffer> <Leader>cf :let @+=expand("<cfile>:~")<bar>let @f=@+<cr>                        " fullpath
    nmap <buffer> <Leader>cv :let @+=fnamemodify(expand("<cfile>"), ":t")<bar>let @f=@+<cr>       " filename only
    nmap <buffer> <Leader>cs :let @+=fnamemodify(expand("<cfile>"), ":t:r")<bar>let @f=@+<cr>     " stem only
endif

" override for grep buffer
nmap <buffer> <Leader>gD :call RunGrep('', expand('%'))<cr>
