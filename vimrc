set nocompatible
scriptencoding utf-8
filetype on

call plug#begin('~/.vim/bundle')

Plug 'vim-scripts/tlib'
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'godlygeek/tabular'
Plug 'preservim/tagbar'
Plug 'vim-scripts/CmdlineComplete'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-unimpaired'
Plug 'SirVer/ultisnips'
Plug 'itchyny/lightline.vim'
Plug 'tpope/vim-commentary'
Plug 'xolox/vim-misc'
Plug 'thinca/vim-localrc'
Plug 'junegunn/fzf.vim'
Plug 'dense-analysis/ale'
Plug 'tmhedberg/matchit'
Plug 'davidhalter/jedi-vim'
Plug 'Glench/Vim-Jinja2-Syntax'
Plug 'Vimjas/vim-python-pep8-indent'
Plug 'lfv89/vim-interestingwords'
Plug 'justinmk/vim-dirvish'

" text objects
Plug 'wellle/targets.vim'
Plug 'jeetsukumaran/vim-pythonsense'
Plug 'coderifous/textobj-word-column.vim'

" Toggle words/expressions
Plug 'AndrewRadev/switch.vim'

if filereadable(glob('~/.vim/localplugins.vim'))
    :source ~/.vim/localplugins.vim
endif

call plug#end()

" enable ctrl-c, ctrl-v, ctrl-a
source $VIMRUNTIME/mswin.vim

" don't want gui find
if has('gui_running')
    unmap <C-F>
endif

set hidden
set nobackup
set tabstop=4
set softtabstop=4
set shiftwidth=4
set nowrap
set novisualbell t_vb=
set noerrorbells
set expandtab
set ignorecase
set smartcase
set nohlsearch
set autowrite
set modelines=5
set backspace=indent,eol,start
set background=dark
set history=10000
set ruler
set incsearch
set autoindent
set smartindent
set smarttab
set report=0
set whichwrap=b,s,h,l,<,>,~,[,]
set nostartofline
set sidescroll=5
set sidescrolloff=10
set statusline=%F%m%r%h%w[%L][%{&ff}]%y[%p%%][%04l,%04v]
set winminheight=0
set shiftround
set showcmd
set grepprg=rg\ --vimgrep\ --no-heading
set matchpairs+=<:>
set iskeyword+=-
set wildignore=*.sw*,*.pyc,node_modules,tags,__pycache__
set shellslash
set laststatus=2
set keymodel=startsel
set listchars=tab:→\ ,trail:•,extends:❯,precedes:❮,nbsp:⍽,conceal:~,eol:$
set splitbelow
set nojoinspaces
set viminfo='1000,<50,s10,h
set tags=./tags;
set shortmess+=I
set showmatch
set matchtime=1
set ttyfast
set diffopt+=algorithm:patience
set complete-=i

if has('gui_macvim')
    set macmeta
    set vb t_vb= 
endif


set dictionary=~/.vim/dict/dict.txt

" bash alias expansion
let $BASH_ENV='~/.bash_aliases'


if has('autocmd')
    filetype plugin on
    filetype plugin indent on

    " Put these in an autocmd group, so that we can delete them easily.
    augroup vimrcEx
        autocmd!

        " When editing a file, always jump to the last known cursor position.
        " Don't do it when the position is invalid or when inside an event handler
        " (happens when dropping a file on gvim).
        " Also don't do it when the mark is in the first line, that is the default
        " position when opening a file.
        autocmd BufReadPost *
            \ if line("'\"") > 1 && line("'\"") <= line("$") |
            \   exe "normal! g`\"" |
            \ endif

        autocmd BufWinEnter,BufRead * :call CheckSyncDir()
    augroup END

    augroup HighlightListChars
        " must be before any calls to colorscheme
        autocmd!
        autocmd ColorScheme * highlight Specialkey guibg=lightgreen
    augroup END

    augroup vimrc     " Source vim configuration upon save
        autocmd!
        autocmd! BufWritePost $MYVIMRC source % | echom "Reloaded vimrc" | redraw
        autocmd! BufWritePost $MYGVIMRC if has('gui_running') | so % | echom "Reloaded " . $MYGVIMRC | endif | redraw
    augroup END
endif

" colorscheme
if &term is# 'win32'
    colorscheme torte
else
    " gvim
    colorscheme iceberg
endif


if has('mac')
    " hash instead of pound
    inoremap £ #
    nnoremap £ #
    cnoremap £ #
    onoremap £ #

    " alt-3
    inoremap <M-3> £
    cnoremap <M-3> £

    " for replace
    nnoremap r£ r#
    nnoremap f£ f#
endif

" LEADER MAPPINGS
" ---------------
"
" \t = new tab
noremap <Leader>t :tabnew<cr>

" \T = new scratch
noremap <Leader>T :tabnew<bar>setlocal buftype=nofile<cr>

" \O = only this tab
noremap <Leader>O :tabonly<cr>

" \wn = split window search cword
nnoremap <Leader>wn :let @/=expand("<cword>")<bar>split<bar>normal n<cr>

" \wN = split window search cword + boundary
nnoremap <Leader>wN :let @/='\<'.expand("<cword>").'\>'<bar>split<bar>normal n<cr>

" \xf = format xml
if executable('xml_pp')
    " xml_pp = xml pretty print from XML::Twig
    map <Leader>xf :silent %!xml_pp - <cr>
    vmap <Leader>xf :!xml_pp - <cr>
endif

" \hf = format html
if executable('html_pp')
    " html_pp = html pretty print using Beautiful Soup
    map <Leader>hf :silent %!html_pp - <cr>
    vmap <Leader>hf :!html_pp - <cr>
endif

if executable('python')
    " \jf = format json
    map <Leader>jf :silent %!python3 -c 'import sys,json;print(json.dumps(json.loads(sys.stdin.read()),sort_keys=True,indent=4))' - <cr><cr>:setf json<cr>
    vmap <Leader>jf :!python3 -c 'import sys,json;print(json.dumps(json.loads(sys.stdin.read()),sort_keys=True,indent=4))' - <cr><cr>

    " \pf = format json
    map <Leader>pf :silent %!python3 -c 'import sys, pprint; pprint.PrettyPrinter(indent=2, compact=True).pprint(eval(sys.stdin.read()))' - <cr><cr>
    vmap <Leader>pf :!python3 -c 'import sys, pprint; pprint.PrettyPrinter(indent=2).pprint(eval(sys.stdin.read()))' - <cr><cr>
endif

" shift-F1 - help current word
nnoremap <S-F1> :execute 'help ' . expand('<cword>')<cr>


" Quoting (plugin/quote.vim)

" \sq = single quote (motion/visual)
nnoremap <Leader>sq :set opfunc=SingleQuote<cr>g@
vnoremap <Leader>sq :<C-U> call SingleQuote('block')<cr>

" \dq = double quote (motion/visual)
nnoremap <Leader>dq :set opfunc=DoubleQuote<cr>g@
vnoremap <Leader>dq :<C-U> call DoubleQuote('block')<cr>

" ,sq = single quote + comma (motion/visual)
nnoremap ,sq :set opfunc=SingleQuoteComma<cr>g@
vnoremap ,sq :<C-U> call SingleQuoteComma('block')<cr>

" ,dq = double quote + comma (motion/visual)
nnoremap ,dq :set opfunc=DoubleQuoteComma<cr>g@
vnoremap ,dq :<C-U> call DoubleQuoteComma('block')<cr>

" \rq = remove quotes (motion/visual)
nnoremap <Leader>rq :set opfunc=RemoveQuote<cr>g@
vnoremap <Leader>rq :<C-U> call RemoveQuote('block')<cr>

" \a, = add comma
nnoremap <Leader>a, :set opfunc=AddComma<cr>g@
vnoremap <Leader>a, :<C-U> call AddComma('block')<cr>

" \d, = remove comma
nnoremap <Leader>d, :set opfunc=RemoveComma<cr>g@
vnoremap <Leader>d, :<C-U> call RemoveComma('block')<cr>

" \ye = copy EOL into clipboard
nnoremap <Leader>ye "*y$

" \yy = copy EOL into clipboard
nnoremap <Leader>yy m`^"*y$``

" \yp = copy inner paragraph into clipboard
nnoremap <Leader>yp "*yip

" \y = copy into clipboard
vnoremap <Leader>y "*y

" \lf = Location open
noremap <Leader>lf :lopen<cr>

" \lc = Location close
noremap <Leader>lc :lclose<cr>

" \dw = remove trailing whitespace
nnoremap <Leader>dw :%s/\s\+$//g<cr>
vnoremap <Leader>dw :s/\s\+$//g<cr>

" \- = ruler
nnoremap <Leader>- o<Esc>80a-<Esc>

" \= ruler
nnoremap <Leader>= o<Esc>80a=<Esc>

" \v = new vertical split
nnoremap <Leader>v :vnew<cr>

" \h = new horizontal split
nnoremap <Leader>h :new<cr>

" \rm = Remove file + confirm
nnoremap <Leader>rm :!rm -i "%"<cr>

" \pw = Pwd
nnoremap <Leader>pw :pwd<cr>

" \wd = change working directory to current buffer
nnoremap <Leader>wd :execute 'cd ' . expand('%:h')<bar>:pwd<cr>

" \ss - save all
nnoremap <Leader>ss :wa<cr>

" \us = Unique sort whole file
nnoremap <Leader>us :%!sort -u<cr>
vnoremap <Leader>us :'<,'>!sort -u<cr>

" \vs = Visual sort
vnoremap <Leader>vs :'<,'>sort<cr>

" \vrc - open vimrc
nnoremap <Leader>vrc :tabedit resolve($MYVIMRC)<cr>

" \vso = reload vimrc manually
nnoremap <Leader>vso :so $MYVIMRC<cr>:echo "sourced $MYVIMRC"<cr>

" \sb = shebang for bash
nnoremap <Leader>sb :normal 1GO<ESC>:.!which env<cr>I#!<ESC>A bash<ESC>

" Vgrep = '^\s*".*<args>.*=' vimrc
"  (including for searching leader)
"  recursively search using 'grepprg'
command! -nargs=1 Vgrep :execute "silent grep! '^\\s*\".*" .
    \ substitute('<args>', '\\', '\\\\', 'g') .
    \ "' " . 
    \ resolve(expand("$MYVIMRC")) . " " . 
    \ fnamemodify(resolve(expand("$MYVIMRC")), ":p:h") . "/ftplugin/*" 
    \ <bar> cwindow

" ReadUrl = download + edit the url
if executable('curl')
    command! -nargs=1 ReadUrl :r!curl -s '<args>'
endif

" \ms = messages
nnoremap <Leader>ms :messages<cr>

" \mc = messages clear
nnoremap <Leader>mc :messages clear<cr>

" \sc = scratch buffer
nnoremap <Leader>sc :setlocal buftype=nofile<cr>


" COMMAND MAPPINGS
" ----------------

" ctrl-a = begin of line (emacs)
cnoremap <C-A> <Home>

" ctrl-e = begin of line (emacs)
cnoremap <C-E> <End>

" ctrl-k = delete to eol (emacs)
cnoremap <c-k> <C-\>estrpart(getcmdline(),0,getcmdpos()-1)<cr>

imap <c-e> <c-o>$
imap <c-a> <c-o>^

cabbrev cs colorscheme

" OTHER MAPPINGS
" --------------
"
" Y = yank to EOL
map Y y$

" forward/back to space
nmap gw f<space>
nmap gb F<space>

" Ctrl-E/Ctrl-Y scroll up/down
nmap <C-up> <C-y>
imap <C-up> <C-o><C-y>
nmap <C-down> <C-e>
imap <C-down> <C-o><C-e>

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" Next/Previous file
" ctrl-n = next file
nnoremap <C-N> :next<cr>

" ctrl-p = prev file
nnoremap <C-P> :prev<cr>

" Buffer switching
nmap L ]b
nmap H [b

" Buffer delete
" Q = delete buffer unless modified
nmap <silent> Q :bd<cr>

" alt-q = delete buffer unconditionally
nmap <silent> <M-q> :bd!<cr>

" ctrl-alt-q = delete buffer unconditionally + close tab
nmap <silent> <C-M-q> :bd!<bar>tabclose<cr>

" ctrl-bs = delete word back
imap <C-BS> <C-O>diw

" Window switching

" ctrl-k = up window
nmap <silent> <c-k> :wincmd k<cr>

" ctrl-k = up window
nmap <silent> <c-j> :wincmd j<cr>

" ctrl-k = up window
nmap <silent> <c-h> :wincmd h<cr>

" ctrl-k = up window
nmap <silent> <c-l> :wincmd l<cr>

" copypath
" \cd = copy directory/path
" \cf = copy fullpath
" \cv = copy filename only
" \cs = copy stem
if has('win32')
    " prefer with windows path backslash
    nmap <Leader>cd :let @+=substitute(expand("%:p:h"), "/", "\\", "g")<cr>
    nmap <Leader>cf :let @+=substitute(expand("%:p"), "/", "\\", "g")<cr>
    nmap <Leader>cv :let @+=substitute(expand("%"), "/", "\\", "g")<cr>
    nmap <Leader>cs :let @+=substitute(expand("%:t:r"), "/", "\\", "g")<cr>
elseif has('unix')
    nmap <Leader>cd :let @+=expand("%:p:h")<cr>
    nmap <Leader>cf :let @+=expand("%:p")<cr>
    nmap <Leader>cv :let @+=expand("%:t")<cr>
    nmap <Leader>cs :let @+=expand("%:t:r")<cr>
endif

" sudo write
if has('unix')
    " :W = sudo write
    command! -bar -nargs=0 W echo "Password: " | silent! exec "write !sudo tee % >/dev/null"  | silent! edit!

    " :WX = chmod+x
    command! -bar -nargs=0 WX silent! | exec "write" | exec "write !chmod a+x % >/dev/null" | silent! edit!
elseif has('win32')
    command! -bar -nargs=0 WR silent! | exec "write" | exec "write !attrib -r %" | silent! edit!
endif

" Map key to toggle opt (normal/insert)
function! MapToggle(key, opt)
    let cmd = ':set '.a:opt.'! \| set '.a:opt."?\<cr>"
    exec 'nnoremap '.a:key.' '.cmd
    exec 'inoremap '.a:key." \<C-O>".cmd
endfunction
command! -nargs=+ MapToggle call MapToggle(<f-args>)

" Toggle (+=|-=) value in `opt` list, in current buffer
" eg: iskeyword, guioptions etc
function! ToggleOptionList(opt, value)
    let values = split(eval('&'.a:opt), ",")
    let present = index(values, a:value) != -1
    let op = (present) ? '-=' : '+='
    exec 'setlocal ' . a:opt . op . a:value
endfunction

" prompt for the character to add/remove from opt
function! ToggleOptionListPrompt(opt)
    let c = getchar()
    if c =~ '^\d\+$'
        let c = nr2char(c)
    endif
    if match(c, '\e') != 0
        call ToggleOptionList(a:opt, c)
    endif
endfunction

" Toggle possible values for var
function! LetToggle(var, possible)
    let idx = 0
    let length = len(a:possible)
    while idx < length
        if a:possible[idx] == a:var
            let next = (idx == length-1) ? 0 : idx + 1
            return a:possible[next]
        endif
        let idx += 1
    endwhile

    " var not in `possible`
    return a:var
endfunction

function! CheckSyncDir()
    if strlen($MYSYNC)
        let buff_dir = expand('%:p:h')
        if match(buff_dir, $MYSYNC) > -1
            setlocal noswapfile
        endif
    endif
endfunction

function! ToggleQuickfix()
    let ids = getqflist({'winid' : 1})
    if get(ids, "winid", 0) != 0
        cclose
    else
        botright copen
    endif
endfunction

" Display-altering option toggles
" F2 = toggle spell
MapToggle <F2> spell

" \ws = toggle wrapscan
MapToggle <Leader>ws wrapscan

" F6 = syntax on/off
map <F6> :if exists("syntax_on") <bar> syntax off <bar> else <bar> syntax enable <bar> endif <cr>

" F7 = toggle hlsearch
MapToggle <F7> hlsearch

" F8 = toggle wrap
MapToggle <F8> wrap

" F9 = toggle list
MapToggle <F9> list

" shift-F8 = toggle number
MapToggle <S-F8> number

" shift-F9 = toggle relativenumber
MapToggle <S-F9> relativenumber

" F10 = toggle scrollbind
MapToggle <F10> scrollbind

" F11 = toggle ignorecase
MapToggle <F11> ignorecase

" F12 = toggle quickfix
map <F12> :call ToggleQuickfix()<cr>

" \ps = toggle paste
MapToggle <Leader>ps paste
set pastetoggle=<Leader>ps

if &diff
    set list
else
    " disabled in diff
    " \ac = toggle autochdir
    MapToggle <Leader>ac autochdir
endif

" \cc = toggle cursorcolumn
MapToggle <Leader>cc cursorcolumn

" \sr = toggle splitright
MapToggle <Leader>sr splitright

" \kd - toggle '.' in `iskeyword`
map <Leader>kd :call ToggleOptionList('iskeyword', '.')<cr>

" \kp - prompt for char to toggle in `iskeyword`
map <Leader>kp :call ToggleOptionListPrompt('iskeyword')<cr>

" \dt - diffthis
map <Leader>dt :if &diff <bar> diffoff <bar> else <bar> diffthis <bar>endif<cr>


" search Sync
" Ngrep = search command wiki
command! -nargs=1 Ngrep silent grep! "<args>" ~/sync/stuff/commands/*  <bar> cwindow

function! GlobCommandsDir(A,L,P)
    let l:pat = '^' . a:A
    let l:result = []
    for fn in split(globpath('~/sync/stuff/commands', '*'), "\n")
        let l:file = fnamemodify(fn, ':t')
        if match(l:file, l:pat) >= 0
            call add(l:result, l:file)
        endif
    endfor
    return l:result
endfunction


" Open command wiki
" Nopen = open command wiki
command! -complete=customlist,GlobCommandsDir -nargs=1 -bang Nopen
    \ :call NopenWindowOrTab("~/sync/stuff/commands/" . "<args>", "<bang>")

function! NopenWindowOrTab(path, bang)
    let cmd = a:bang == "!" ? 'edit' : 'tabedit'
    execute cmd a:path
endfunction

" alt-N = switch to tab
nnoremap <M-1> 1gt
nnoremap <M-2> 2gt
nnoremap <M-3> 3gt
nnoremap <M-4> 4gt
nnoremap <M-5> 5gt
nnoremap <M-6> 6gt
nnoremap <M-7> 7gt
nnoremap <M-8> 8gt
nnoremap <M-9> 9gt

" ===============
" PLUGIN SETTINGS
" ===============


" Tagbar
" ------
" F3 = toggle tagbar
map <F3> :TagbarToggle<cr>

" Fugitive
" --------
" \cg = copy git path relative
nnoremap <Leader>cg :let @+=(FugitiveExtractGitDir('.') !=# '' ? FugitivePath(@%, '') : '')<cr>

" \gd = Gvdiff
nnoremap <Leader>gd :Gvdiff<cr>

" \gs = Gstatus
nnoremap <Leader>gs :Gstatus<cr>

" \gp = Git pull
nnoremap <Leader>gp :Git pull<bar>echo "pulled"<cr>

" \gu = Git push
nnoremap <Leader>gu :Git push<bar>echo "pushed"<cr>

" \gb = Gblame<cr>
nnoremap <Leader>gb :Gblame<cr>

" \gR = Gread<cr>
nnoremap <Leader>gR :Gread<bar>echo "git checkout -f"<cr>

" \gS = Git stash save<cr>
nnoremap <Leader>gS :Git stash save<cr>

" \gP = Git stash pop
nnoremap <Leader>gP :Git stash pop<cr>

" \gL = Git stash save
nnoremap <Leader>gL :Git stash list<cr>


" Dirvish
" -------
nmap <F4> <Plug>(dirvish_up):echo(expand('%'))<cr>
nmap <S-F4> <Plug>(dirvish_vsplit_up)

" \F4 = dirvish from this directory or file
nmap <silent><Leader><F4> :<C-U>exe 'tabedit +Dirvish\ ' .expand('%:p')<cr>

" F4 = :Dirvish (commandmode)
cnoremap <F4> Dirvish<Space>


" Lightline
" ---------
let g:lightline = {
    \   'active': {
    \       'left': [ [ 'mode', 'paste' ],
    \               [ 'gitbranch', 'readonly', 'filename', 'modified' ] ],
    \       'right': [ [ 'percent', 'lineinfo' ],
    \                  [ 'fileformat', 'filetype', 'ALEenabled' ] ]
    \   },
    \   'component_function': {
    \       'gitbranch': 'fugitive#head',
    \       'ALEenabled': 'LightLineALEEnabled',
    \   },
    \ }

function! LightLineALEEnabled() abort
    if getbufvar('', 'ale_enabled', get(g:, 'ale_enabled', 0))
        return 'lint'
    else
        return ''
    endif
endfunction


" ALE
" ---
" by default ALE is off, use F5 to toggle
" enabled in diff
let g:ale_enabled = str2nr(&diff)

" python: needs flake8
"   ignore errors/warnings:
"    E501 line too long
"    W391 blank line at end of file
"    F403 unabled to detect undefined names
let g:ale_python_flake8_executable = 'python3'
let g:ale_python_flake8_options = '-m flake8 --ignore=E501,E731,W391,F403'
let g:ale_linters = {
    \   'javascript': ['eslint'],
    \   'python': ['flake8'],
    \   'c': ['gcc'],
    \   'go': ['gobuild'],
    \   'erlang': ['erlc'],
    \ }

let g:ale_fixers = {
    \   'python': ['black'],
    \   'javascript': ['eslint']
    \ }

" F5 = toggle ALE
nmap <F5> :ALEToggle<cr>
nmap <S-F5> :ALEToggleBuffer<cr>
imap <F5> <C-o>:ALEToggle<cr>
vmap <F5> :ALEToggle<cr>

" ctrl-F5 = ALEFix
nmap <C-F5> :ALEFix<cr>

" ]g = next ALE issue
nnoremap ]g :ALENext<cr>

" [g = prev ALE issue
nnoremap [g :ALEPrevious<cr>


" Switch
" ------
" \gs = Switch

" 1 - dd/mm/yyyy to isodate
" 2 - 'X \w+ Y' to 'Y \w+ X'
let g:switch_custom_definitions =
    \ [
    \   {
    \       '\(\d\+\)[/.-]\(\d\+\)[/.-]\(\d\+\)': '\3-\2-\1',
    \       '\(\w\+\)\(\s\+\w\+\s\+\)\(\w\+\)': '\3\2\1',
    \   }
    \ ]

" 1 - true/false
" 2 - enabled/disabled
if exists('*switch#NormalizedCase')
    let g:switch_custom_definitions += [
    \   switch#NormalizedCase(['true', 'false']),
    \   switch#NormalizedCase(['enabled', 'disabled'])
    \ ]
endif

" Jedi
" -----
let g:jedi#popup_on_dot = 0
let g:jedi#use_splits_not_buffers = 'bottom'


" UltiSnips
" ---------
let g:UltiSnipsUsePythonVersion = 3


" FZF
" -------
nnoremap <Leader>p :Files!<cr>
nnoremap <Leader>P :execute 'Files! ' . expand('%:p:h')<cr>
nnoremap <Leader>f :History!<cr>
nnoremap <Leader>b :Buffers!<cr>
nnoremap <Leader>gr :Rg<Space>
nnoremap <Leader>gw :Rg <cword><cr>

let g:fzf_preview_window = ''

if executable('fd')
    let $FZF_DEFAULT_COMMAND='fd -t f --hidden --exclude .git --exclude node_modules --exclude _build --exclude "*.sw?" --exclude "*.pyc" --exclude="*.beam"'
endif


" Commentary
" ----------

" gcaf = comment whole file
nmap gcaf gggcG

" dcaf = delete whole file
nmap dcaf ggdG

" ===========
" End Plugins
" ===========

syntax enable

if filereadable(glob('~/.vim/local.vim'))
    :source ~/.vim/local.vim
endif
