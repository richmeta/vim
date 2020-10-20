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

set columns=150
set lines=50
set guicursor=n:blinkon0
