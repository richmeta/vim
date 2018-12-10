if !has("unix")
  set guifont=Consolas:h10:cANSI
else
  if has("mac")
    " set guifont=Droid\ Sans\ Mono:h12
    set guifont=Fantasque\ Sans\ Mono\ Regular:h15 
  else
    set guifont=Consolas\ 11
  endif
endif
set columns=150
set lines=50
