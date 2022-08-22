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

" helpers for cp / mv
command! -buffer -nargs=1 -complete=file Cp :!cp "<cfile>"<space><args>
command! -buffer -nargs=1 -complete=file Mv :!mv "<cfile>"<space><args>

" cp = copy file under cursor (dirvish)
nmap <buffer> cp :Cp<space>%/

" mv = move file under cursor (dirvish)
nmap <buffer> mv :Mv<space>%/

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

" open file under cursor (no split)
nmap <buffer><nowait><silent> <cr> :<C-U>call dirvish#open("edit", 0)<cr>:echo(expand('%'))<cr>

" \Pb = CtrlP (dirvish dir)
nnoremap <buffer> <Leader>P :execute 'CtrlP ' . expand('%:p')<cr>

" r-click = preview
nmap <RightMouse> p

" h = up dir (dirvish) [like vifm]
nmap <buffer> <silent> h <Plug>(dirvish_up)

" l = open (dirvish) [like vifm]
nmap <buffer> <silent> l :<C-U>call dirvish#open("edit", 0)<cr>:echo(expand('%'))<cr>

" copypath
nmap <silent> <Leader>cd :call file#clip(file#ex_dir(), 1)<cr>         " directory
nmap <silent> <Leader>cf :call file#clip(file#ex_full(), 1)<cr>        " full path
nmap <silent> <Leader>cv :call file#clip(file#ex_filename(), 1)<cr>    " filename only
nmap <silent> <Leader>cs :call file#clip(file#ex_stem(), 1)<cr>        " stem only

" override for grep buffer
nmap <buffer> <Leader>gD :call RunGrep('', expand('%'))<cr>
