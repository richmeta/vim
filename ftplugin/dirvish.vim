" \F4 = close dirvish window
nmap <leader><F4> :close<CR>

" Esc close dirvish buffer
nmap <Esc> gq

" md = mkdir (dirvish)
nmap md :!mkdir %/

" cp = copy file under cursor (dirvish)
nmap cp :!cp "<cfile>" 

" mv = move file under cursor (dirvish)
nmap mv :!mv "<cfile>" 

" rm = delete file under cursor (dirvish)
nmap rm :!rm -i "<cfile>" <CR>

" open file under cursor in new tab (dirvish)
nnoremap <silent> t :call dirvish#open('tabedit', 0)<CR>
xnoremap <silent> t :call dirvish#open('tabedit', 0)<CR>
