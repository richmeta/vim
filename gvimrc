if !has('unix')
  set guifont=Consolas:h9:cANSI
else
  if has('mac')
    set guifont=Fantasque\ Sans\ Mono\ Regular:h15 
    let g:NERDTreeDirArrowExpandable = '.'
    let g:NERDTreeDirArrowCollapsible = '↓'
  else
    set guifont=Consolas\ 11
  endif
endif
set columns=150
set lines=50
set guicursor=n:blinkon0
