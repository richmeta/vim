" Change the color scheme from a list of color scheme names.
" Version 2010-09-12 from http://vim.wikia.com/wiki/VimTip341
"
"
" Fav colorschemes

"  Green
"  abra
"  apprentice
"  candy
"  candypaper
"  chance-of-storm
"  darkbone
"  deepsea
"  desertex
"  eclm_wombat
"  elda
"  feral
"  flatlandia
"  flattened_dark
"  frozen
"  jellybeans
"  lizard
"  lxvc
"  madeofcode
"  navajo-night
"  nefertiti
"  nightflight2
"  oceandeep
"  phd
"  phoenix
"  predawn
"  pt_black
"  sourcerer
"  symfony
"  tesla
"  tir_black
"  thornbird
"  underwater-mod
"  vanzan_color
"  wombat
"  xterm16

if v:version < 700 || exists('loaded_setcolors') || &compatible
    finish
endif

let loaded_setcolors = 1
let s:mycolors = []

" Set list of color scheme names that we will use, except
" argument 'now' actually changes the current color scheme.
function! s:SetColors()
    let paths = split(globpath(&runtimepath, 'bundle/*/colors/*.vim'), "\n")
    let s:mycolors = uniq(sort(map(paths, 'fnamemodify(v:val, ":t:r")')))
endfunction

" Set next/previous/random (how = 1/-1/0) color from our list of colors.
" The 'random' index is actually set from the current time in seconds.
" Global (no 's:') so can easily call from command line.
function! NextColor(how)
    if len(s:mycolors) == 0
        call s:SetColors()
    endif
    if exists('g:colors_name')
        let current = index(s:mycolors, g:colors_name)
    else
        let current = -1
    endif
    let missing = []
    let how = a:how
    for i in range(len(s:mycolors))
        if how == 0
            let current = localtime() % len(s:mycolors)
            let how = 1  " in case random color does not exist
        else
            let current += how
            if !(0 <= current && current < len(s:mycolors))
                let current = (how>0 ? 0 : len(s:mycolors)-1)
            endif
        endif
        try
            echom 'setting to ' . s:mycolors[current]
            execute 'colorscheme '.s:mycolors[current]
            break
        catch /E185:/
            call add(missing, s:mycolors[current])
        endtry
    endfor
    redraw
    echom 'colorscheme '.s:mycolors[current]
    if len(missing) > 0
        echom 'Error: colorscheme not found:' join(missing)
    endif
endfunction

let g:lightline = {
    \   'active': {
    \       'left': [ [ 'mode', 'paste' ],
    \               [ 'gitbranch', 'readonly', 'filename', 'modified' ] ],
    \       'right': [ [ 'colorscheme' ] ], 
    \   },
    \   'component_function': {
    \       'gitbranch': 'fugitive#head',
    \       'colorscheme': 'Colorsc'
    \   },
    \ }

function! Colorsc()
    try
        return g:colors_name
    catch /^Vim:E121/
        return 'unknown'
    endtry
endfunction

call lightline#init()
call lightline#colorscheme()
call lightline#update()

nnoremap <Leader>cn :call NextColor(1)<CR>
nnoremap <Leader>cp :call NextColor(-1)<CR>
nnoremap <Leader>cr :call NextColor(0)<CR>

