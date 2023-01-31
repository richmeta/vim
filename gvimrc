if filereadable(glob('~/.vim/font.vim'))
    " set the font independently
    :source ~/.vim/font.vim
else
    " otherwise some defauilts
    if !has('unix')
        set guifont=Consolas:h9:cANSI
    elseif has('mac')
        set guifont=FiraMono-Regular:h14
    else
        set guifont=Consolas\ 10
    endif
endif

" For CTRL-V to work autoselect must be off.
" On Unix we have two selections, autoselect can be used.
if !has("unix")
  set guioptions-=a
endif

if !has('linux')
    set columns=150
    set lines=50
endif

set guicursor=n:blinkon0

" relative filename in tab title
set guitablabel=%f

if has('GUI_GTK')
    set guioptions-=T
endif
