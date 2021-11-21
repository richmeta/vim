set nocompatible
scriptencoding utf-8
filetype on

" ~/.vim or ~/vimfiles
let s:vim_home_dir = fnamemodify(resolve(expand("$MYVIMRC")), ":p:h")

call plug#begin(s:vim_home_dir . '/bundle')

Plug 'godlygeek/tabular'
Plug 'preservim/tagbar'
Plug 'vim-scripts/CmdlineComplete'
Plug 'machakann/vim-sandwich'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-unimpaired'
Plug 'SirVer/ultisnips'
Plug 'itchyny/lightline.vim'
Plug 'tpope/vim-commentary'
Plug 'thinca/vim-localrc'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'nixprime/cpsm', { 'do': 'env PY3=ON ./install.sh' }
Plug 'd11wtq/ctrlp_bdelete.vim'
Plug 'dense-analysis/ale'
Plug 'andymass/vim-matchup'
Plug 'davidhalter/jedi-vim'
Plug 'Glench/Vim-Jinja2-Syntax'
Plug 'Vimjas/vim-python-pep8-indent'
Plug 'justinmk/vim-dirvish'
Plug 'vimwiki/vimwiki'
Plug 't9md/vim-quickhl'

" text objects
Plug 'kana/vim-textobj-user'

" af: a function
" if: inner function
" ac: a class
" ic: inner class
" [pf / ]pf: move to next/previous function
" [pc / ]pc: move to next/previous class
Plug 'bps/vim-textobj-python'

" al = select whole line
" il = select line without leading/trailing space
Plug 'kana/vim-textobj-line'

" a, = select parameter (inc comma)
" i, = select parameter (without comma)
Plug 'sgur/vim-textobj-parameter'

" aq = select incl quote
" iq = select excl quote 
Plug 'beloglazov/vim-textobj-quotes'

" au = select url incl trailing spaces
" iu = select url excl trailing spaces
Plug 'jceb/vim-textobj-uri'

" ac = select around column, expanded to the largest iw
" ic = select inner column, based on the iw
" aC = select around COLUMN, expanded to the largest iW
" iC = select inner COLUMN, based on iW
Plug 'idbrii/textobj-word-column.vim'

" ae = select entire buffer
" ie = select buffer except leading/trailing empty lines
Plug 'kana/vim-textobj-entire'

" af = select function
" if = select inner function
" aF = select function with blank lines
" iF = select inner function with blank lines
Plug 'kana/vim-textobj-function'

" ai = select block similarly indented lines
" ii = select block similarly indented lines
" aI = select block same level indented lines
" iI = select block same level indented lines
Plug 'kana/vim-textobj-indent'

" ak = select key (in k/v pair) with quotes
" ik = select key (in k/v pair)
" av = select value (in k/v pair) with quotes
" iv = select value (in k/v pair)
Plug 'vimtaku/vim-textobj-keyvalue'


" Toggle words/expressions
Plug 'AndrewRadev/switch.vim'

if filereadable(glob(s:vim_home_dir . '/localplugins.vim'))
    execute ':source ' . s:vim_home_dir . '/localplugins.vim'
endif

call plug#end()

" enable ctrl-c, ctrl-v, ctrl-a
behave mswin

if has("clipboard")
    " ctrl-x = Cut
    vnoremap <C-X> "+x

    " ctrl-c = Copy
    vnoremap <C-C> "+y

    " ctrl-v = Paste
    map <C-V> "+gP
    cmap <C-V> <C-R>+

    if has('unix')
        exe 'inoremap <script> <C-V> <C-G>u' . paste#paste_cmd['i']
        exe 'vnoremap <script> <C-V> ' . paste#paste_cmd['v']
    endif
endif

" Use CTRL-Q to do what CTRL-V used to do
noremap <C-Q> <C-V>

" Use CTRL-S for saving, also in Insert mode (<C-O> doesn't work well when
" using completions).
noremap <C-S> :update<CR>
vnoremap <C-S> <C-C>:update<CR>
inoremap <C-S> <Esc>:update<CR>gi

" For CTRL-V to work autoselect must be off.
" On Unix we have two selections, autoselect can be used.
if !has("unix")
  set guioptions-=a
endif

" Ctrl-A=Select all
noremap <C-A> gggH<C-O>G
inoremap <C-A> <C-O>gg<C-O>gH<C-O>G
cnoremap <C-A> <C-C>gggH<C-O>G
onoremap <C-A> <C-C>gggH<C-O>G
snoremap <C-A> <C-C>gggH<C-O>G
xnoremap <C-A> <C-C>ggVG

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
set scrolloff=2
set statusline=%F%m%r%h%w[%L][%{&ff}]%y[%p%%][%04l,%04v]
set winminheight=0
set shiftround
set showcmd
set matchpairs+=<:>
set iskeyword+=-
set wildmenu
set wildignore=*.sw*,*.pyc,node_modules,tags,__pycache__,.DS_Store,*/\.git/*
set shellslash
set laststatus=2
set keymodel=startsel
set listchars=tab:→\ ,trail:␣,extends:❯,precedes:❮,nbsp:⍽,conceal:~,eol:$
set splitbelow
set nojoinspaces
set viminfo='1000,<50,s10,h
set tags=./tags,tags;
set shortmess+=I
set showmatch
set matchtime=1
set ttyfast
set diffopt+=algorithm:patience
set complete-=i
set termguicolors
set isfname+=32  " allow space in filenames
set formatoptions+=j " Delete comment character when joining commented lines
set tabpagemax=50
set tagbsearch
set nofixendofline

if executable('rg')
    set grepprg=rg\ --vimgrep\ --no-heading
endif

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
        autocmd! BufWritePost vimrc,.vimrc source $MYVIMRC | echom "Reloaded " . $MYVIMRC | redraw
        autocmd! BufWritePost gvimrc,.gvimrc if has('gui_running') | source $MYGVIMRC | echom "Reloaded " . $MYGVIMRC | endif | redraw
    augroup END
endif

" colorscheme
if &term is# 'win32'
    colorscheme torte
else
    " gvim
    colorscheme iceberg
endif

" hash instead of pound
inoremap £ #
nnoremap £ #
cnoremap £ #

" alt-3
inoremap <M-3> £
cnoremap <M-3> £

" for replace
nnoremap r£ r#
nnoremap f£ f#
nmap t£ t#
nmap f£ f#


" LEADER MAPPINGS
" ---------------
"
" \t = new tab
function! Tabnew()
    let found = buff#find_first_empty()
    let tabnr = -1
    if found != -1
        let tabnr = buff#find_tab_for_buffer(found)
    endif
    if tabnr == -1
        :tabnew
    else
        execute 'normal ' . tabnr . 'gt'
    endif
endfunction

" noremap <Leader>t :call Tabnew()<cr>
noremap <Leader>t :tabnew<cr>

" \T = new scratch
noremap <Leader>T :tabnew<bar>setlocal buftype=nofile<cr>

" alt-t = tabclose
noremap <m-t> :tabclose<cr>

" \O = only this tab
noremap <Leader>O :tabonly<cr>

" \o = tabedit file
nnoremap <Leader>o :tabedit<space>

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

if executable('python3')
    " \jf = format json
    map <Leader>jf :silent %!python3 -c 'import sys,json;print(json.dumps(json.loads(sys.stdin.read()),sort_keys=False,indent=4))' - <cr><cr>:setf json<cr>
    vmap <Leader>jf :!python3 -c 'import sys,json;print(json.dumps(json.loads(sys.stdin.read()),sort_keys=False,indent=4))' - <cr><cr>

    " \pf = format json
    map <Leader>pf :silent %!python3 -c 'import sys, pprint; pprint.PrettyPrinter(indent=2, compact=True).pprint(eval(sys.stdin.read()))' - <cr><cr>
    vmap <Leader>pf :!python3 -c 'import sys, pprint; pprint.PrettyPrinter(indent=2).pprint(eval(sys.stdin.read()))' - <cr><cr>
endif

if executable('erlfmt')
    " \ef = format with erlfmt
    map <Leader>ef :silent %!erlfmt --print-width 120 - <cr><cr>
    vmap <Leader>ef :!erlfmt --print-width 120 - <cr><cr>
endif

" shift-F1 - help current word
nnoremap <S-F1> :execute 'help ' . expand('<cword>')<cr>
vnoremap <S-F1> :<C-U>execute 'help ' . getline("'<")[getpos("'<")[2]-1:getpos("'>")[2]-2]<cr>


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

" \wg = change working directory to git root
nnoremap <Leader>wg :execute 'cd ' . fnamemodify(FugitiveGitDir(), ':h')<cr>

" \ss - save all
nnoremap <Leader>ss :wa<cr>

" \us = Unique sort whole file
nnoremap <Leader>us :%!sort -u<cr>
vnoremap <Leader>us :'<,'>!sort -u<cr>

" \vs = Visual sort
vnoremap <Leader>vs :'<,'>sort<cr>

" \vrc - open vimrc
nnoremap <Leader>vrc :exec 'tabedit ' . resolve($MYVIMRC)<cr>

" \vso = reload vimrc manually
nnoremap <Leader>vso :so $MYVIMRC<cr>:echo "sourced $MYVIMRC"<cr>

" \sb = shebang for bash
nnoremap <Leader>sb :normal 1GO<ESC>:.!which env<cr>I#!<ESC>A bash<ESC>

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

" ctrl-a = emacs begin of line (commandmode)
cnoremap <C-A> <Home>

" ctrl-e = emacs begin of line (commandmode)
cnoremap <C-E> <End>

" ctrl-k = emacs delete to eol (commandmode)
cnoremap <c-k> <C-\>estrpart(getcmdline(),0,getcmdpos()-1)<cr>

" ctrl-e = eol (ins)
imap <c-e> <c-o>$

" ctrl-a = home (ins)
imap <c-a> <c-o>^

" w!! = sudo write
cmap w!! w !sudo tee > /dev/null %

" cs = colorscheme[c]
cabbrev cs colorscheme

" T = tabedit[c]
cabbrev T tabedit


cabbrev _config ~/.config
cabbrev _sshconfig ~/.ssh/config


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

" ctrl-bs (ins) = delete word back
imap <C-BS> <C-O>diw

" ctrl-p (ins) put from " register
" alt-p (ins) PUT from " register
inoremap <m-p> <C-O>P
inoremap <C-P> <C-O>p

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
" \cd = copy directory/path (and "f)
" \cf = copy fullpath (and "f)
" \cv = copy filename only (and "f)
" \cs = copy stem (and "f)
if has('win32')
    " prefer with windows path backslash
    nmap <Leader>cd :let @+=substitute(expand("%:p:h"), "/", "\\", g")<bar>let@f=@+<cr>
    nmap <Leader>cf :let @+=substitute(expand("%:p"), "/", "\\", "g")<bar>let@f=@+<cr>
    nmap <Leader>cv :let @+=substitute(expand("%"), "/", "\\", "g")<bar>let@f=@+<cr>
    nmap <Leader>cs :let @+=substitute(expand("%:t:r"), "/", "\\", "g")<bar>let@f=@+<cr>
elseif has('unix')
    nmap <Leader>cd :let @+=expand("%:~:h")<bar>let @f=@+<cr>     " directory
    nmap <Leader>cf :let @+=expand("%:~")<bar>let @f=@+<cr>       " full path
    nmap <Leader>cv :let @+=expand("%:t")<bar>let @f=@+<cr>       " filename only
    nmap <Leader>cs :let @+=expand("%:t:r")<bar>let @f=@+<cr>     " stem only
endif

" <ctrl-c><ctrl-d> (ins) = insert directory/path
" <ctrl-c><ctrl-f> (ins) = insert fullpath
" <ctrl-c><ctrl-v> (ins) = insert filename only
" <ctrl-c><ctrl-s> (ins) = insert stem
imap <C-C><C-D> <C-O>:let @x=expand("%:p:h")<cr><C-R>x
imap <C-C><C-F> <C-O>:let @x=expand("%:p")<cr><C-R>x
imap <C-C><C-V> <C-O>:let @x=expand("%:t")<cr><C-R>x
imap <C-C><C-S> <C-O>:let @x=expand("%:t:r")<cr><C-R>x

" Ctrl-\ = (terminal) exit insertmode
tnoremap <C-\> <C-\><C-n>

" prevent Ctrl-S freeze
tmap <C-S> <Nop>

" \mt = open terminal at this dir
map <Leader>mt :let $VIM_DIR=expand('%:p:h')<cr>:terminal<cr>cd $VIM_DIR<cr>

" \dt = diffthis
map <Leader>dt :if &diff <bar> diffoff <bar> else <bar> diffthis <bar>endif<cr>

" \gr = grep
nnoremap <Leader>gr :grep<Space>

" \gw = grep current word
nnoremap <silent><Leader>gw :grep <cword><cr>

" \gw = grep current WORD
nnoremap <silent><Leader>gW :grep <cWORD><cr>

" \Ctrl-] = open tag in new tab
nnoremap <silent><Leader><C-]> <C-w><C-]><C-w>T

" FUNCTION BASED MAPS
" ===================

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
    " todo: support multiple dirs
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
    set guioptions+=b
else
    " disabled in diff
    " \ac = toggle autochdir
    MapToggle <Leader>ac autochdir
endif

" \cc = toggle cursorcolumn
MapToggle <Leader>cc cursorcolumn

" \sr = toggle splitright
MapToggle <Leader>sr splitright

" \kd = toggle '.' in `iskeyword`
map <Leader>kd :call ToggleOptionList('iskeyword', '.')<cr>

" \kp = prompt for char to toggle in `iskeyword`
map <Leader>kp :call ToggleOptionListPrompt('iskeyword')<cr>


" CUSTOM COMMANDS
" ---------------
"
" Vgrep = '^\s*".*<args>.*=' vimrc
"  (including for searching leader)
"  recursively search using 'grepprg'
command! -nargs=1 Vgrep :execute "silent grep! '^\\s*\".*" .
    \ substitute('<args>', '\\', '\\\\', 'g') .
    \ "' " .
    \ resolve(expand("$MYVIMRC")) . " " .
    \ s:vim_home_dir . "/ftplugin/*"
    \ <bar> cwindow


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

function! NopenWindowOrTab(dir, filename, bang)
    let cmd = a:bang == "!" ? 'edit' : 'tabedit'
    let path = a:dir . "/" . a:filename
    if a:filename !~ "\.wiki$"
        let altpath = globpath(a:dir, a:filename . ".wiki")
        if !empty(altpath)
            let path = altpath
        endif
    endif
    execute cmd path
endfunction

" Open command wiki
" Nopen = open command wiki
command! -complete=customlist,GlobCommandsDir -nargs=1 -bang Nopen
    \ :call NopenWindowOrTab("~/sync/stuff/commands/", "<args>", "<bang>")


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

let g:tagbar_type_elixir = {
    \ 'ctagstype' : 'elixir',
    \ 'kinds' : [
        \ 'p:protocols',
        \ 'm:modules',
        \ 'e:exceptions',
        \ 'y:types',
        \ 'd:delegates',
        \ 'f:functions',
        \ 'c:callbacks',
        \ 'a:macros',
        \ 't:tests',
        \ 'i:implementations',
        \ 'o:operators',
        \ 'r:records'
    \ ],
    \ 'sro' : '.',
    \ 'kind2scope' : {
        \ 'p' : 'protocol',
        \ 'm' : 'module'
    \ },
    \ 'scope2kind' : {
        \ 'protocol' : 'p',
        \ 'module' : 'm'
    \ },
    \ 'sort' : 0
\ }


" Fugitive
" --------
" \cg = copy git path relative
nnoremap <Leader>cg :let @+=(FugitiveExtractGitDir('.') !=# '' ? FugitivePath(@%, '') : expand('%'))<cr>

" \gd = Gvdiff
nnoremap <Leader>gd :Gvdiff<cr>

" \gs = Gstatus
nnoremap <Leader>gs :Git<cr>

" \gp = Git pull
nnoremap <Leader>gp :Git pull<bar>echo "pulled"<cr>

" \gu = Git push
nnoremap <Leader>gu :Git push<bar>echo "pushed"<cr>

" \gb = Gblame<cr>
nnoremap <Leader>gb :Git blame<cr>

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

" <F4> = dirvish current dir
nmap <F4> <Plug>(dirvish_up):echo(expand('%'))<cr>

" g<F4> = dirvish git root dir
nmap g<F4> :execute 'Dirvish ' . fnamemodify(FugitiveGitDir(), ':h')<cr>

" <Ctrl-F4> = dirvish git root dir (newtab)
nmap <silent><C-F4> :execute 'tabedit +Dirvish\ ' . fnamemodify(FugitiveGitDir(), ':h')<cr>

" Shift-<F4> = vsplit + dirvish current dir
nmap <S-F4> <Plug>(dirvish_vsplit_up)

" \F4 = dirvish from this directory or file (tab)
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

" python: needs flake8 (pref globally installed)
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
let g:UltiSnipsEditSplit = "tabdo"

" \se = Edit Snippets for filetype
nnoremap <Leader>se :UltiSnipsEdit<cr>

" \sr = Reload Snippets for filetype
nnoremap <Leader>sr :call UltiSnips#RefreshSnippets()<cr>


" Ctrlp
" -------
if has('win32')
    let g:ctrlp_user_command = 'dir %s /-n /b /s /a-d'
else
    if executable('fd')
        " eg: fd "" '<full directory path>' -tf --color=never --glob
        let g:ctrlp_user_command = 'fd "" %s -tf -c never '
    else
        let g:ctrlp_user_command = 'find %s -type f'
    endif
endif

" ctrl-2 = delete buffer (ctrlp)
" ctrl-z + ctrl-2 = mark many + delete buffer (ctrlp)
call ctrlp_bdelete#init()

let g:ctrlp_match_func = { 'match': 'cpsm#CtrlPMatch' }
let g:ctrlp_lazy_update = 200
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_max_files = 0
let g:ctrlp_mruf_max = &history
let g:ctrlp_match_current_file = 0
let g:ctrlp_clear_cache_on_exit = 0


" alt-p = ctrlp
let g:ctrlp_map = '<m-p>'

" \p = CtrlP (git root)
nnoremap <Leader>p :CtrlP<cr>

" \P = CtrlP (buffer dir)
nnoremap <Leader>P :CtrlPCurFile<cr>

" \D = CtrlP (cwd)
nnoremap <Leader>D :CtrlPCurWD<cr>

" \f = CtrlPMRU
nnoremap <Leader>f :CtrlPMRU<cr>

" \b = :CtrlPBuffer
nnoremap <Leader>b :CtrlPBuffer<cr>

" \Ctrl-t = :CtrlPTag
nnoremap <Leader><c-t> :CtrlPBuffer<cr>



" VimWiki
" -------
" note: 'g:vimwiki_list' set in local.vim

if exists("$MYSYNC")
    let g:vimwiki_list = [{'path': "$MYSYNC/stuff/commands", 'name': 'Commands'}]
endif

" prevent link shortening
let g:vimwiki_url_maxsave = 0

" stop concealing special chars
let g:vimwiki_conceallevel = 0

" alt-enter = follow wiki link
nmap <m-CR> <Plug>VimwikiFollowLink

" alt-bs = go back from link
nmap <m-Backspace> <Plug>VimwikiGoBackLink

" \wl = list/select wiki
" overriding default \ws used in wrapscan
nmap <Leader>wl <Plug>VimwikiUISelect

" Quickhl
" -------

" \km = mark the WORD
nmap <Leader>km <Plug>(quickhl-manual-this-whole-word)
xmap <Leader>km <Plug>(quickhl-manual-this-whole-word)

" \kM = mark the word
nmap <Leader>kM <Plug>(quickhl-manual-this)
xmap <Leader>kM <Plug>(quickhl-manual-this)


" \kk = clear all marks
nmap <Leader>kk <Plug>(quickhl-manual-reset)
xmap <Leader>kk <Plug>(quickhl-manual-reset)

" \kv = mark visual selection
vmap <Leader>kv y:QuickhlManualAdd<space><C-R>"<cr>

" \kq = prompt for what to select
nmap <Leader>kq :QuickhlManualAdd<space>

" alt-n = next mark
" alt-N = prev mark
nmap <m-n> <Plug>(quickhl-manual-go-to-next)
nmap <m-N> <Plug>(quickhl-manual-go-to-prev)



" ===========
" End Plugins
" ===========

syntax enable
filetype indent plugin on

if filereadable(glob(s:vim_home_dir . '/local.vim'))
    execute ':source ' . s:vim_home_dir . '/local.vim'
endif
