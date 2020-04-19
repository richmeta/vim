set nocompatible
scriptencoding utf-8
filetype off

if has('win32')
    let g:_vimrc = '~/.vimfiles/vimrc'
else
    let g:_vimrc = '~/.vim/vimrc'
endif

call plug#begin('~/.vim/bundle')

Plug 'scrooloose/nerdtree'
Plug 'vim-scripts/tlib'
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'godlygeek/tabular'
Plug 'majutsushi/tagbar'
Plug 'vim-scripts/CmdlineComplete'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-unimpaired'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'itchyny/lightline.vim'
Plug 'tpope/vim-commentary'
Plug 'xolox/vim-misc'
Plug 'thinca/vim-localrc'
Plug 'Yggdroot/LeaderF'
Plug 'mileszs/ack.vim'
Plug 'dense-analysis/ale'
Plug 'tmhedberg/matchit'
Plug 'isRuslan/vim-es6'
Plug 'davidhalter/jedi-vim'
Plug 'Glench/Vim-Jinja2-Syntax'
Plug 'Vimjas/vim-python-pep8-indent'

" text objects
Plug 'wellle/targets.vim'
Plug 'jeetsukumaran/vim-pythonsense'
Plug 'coderifous/textobj-word-column.vim'

" Toggle words/expressions
Plug 'AndrewRadev/switch.vim'

" VimSript Testing
" Plug 'junegunn/vader.vim'

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
set grepprg=ag
set matchpairs+=<:>
set iskeyword+=-
set wildignore=*.sw*,*.pyc
set shellslash
set laststatus=2
set keymodel=startsel
set listchars=tab:\|\ ,trail:.,extends:❯,precedes:❮,nbsp:⍽,conceal:⋰
set splitbelow
set splitright
set nojoinspaces
set viminfo='1000,<50,s10,h
set tags=./tags;
set shortmess+=I
set showmatch
set matchtime=1
set ttyfast

if has('gui_macvim')
    set macmeta
endif


set dictionary=~/.vim/dict/dict.txt

" bash alias expansion
let $BASH_ENV='~/.bash_aliases'

" colorscheme
if &term is# 'win32'
  " console vim, |lucius| doesn't support console
  colorscheme torte
else
  " gvim
  colorscheme oceandeep
endif

if has('autocmd')
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

    " for vim-es6
    augroup filetype javascript syntax=javascript

    augroup myfiletypes
        autocmd!
        autocmd FileType javascript,html,yaml setlocal ai sw=2 ts=2
        autocmd FileType javascript setlocal suffixesadd=.js,.jsx
        autocmd FileType python set ts=4 sw=4
        autocmd FileType vim set iskeyword+=:

        " 1 - kwargs and dict  {'key': 'value'} => {key='value'}
        " 2 - kwargs and dict  {key='value'}    => {'key': 'value'}
        " 3 - import \k+ => from \k import
        " 4 - from \k import => import \k+
        autocmd FileType python let b:switch_custom_definitions = 
            \ [
            \   {
            \       '\(\k\+\)=\([^),]\+\)': '''\1'': \2',
            \       '[''"]\(\k\+\)[''"]:\s*\([^},]\+\)': '\1=\2',
            \       'import\s\+\(\k\+\)': 'from \1 import ',
            \       'from\s\+\(\k\+\)\s\+import\s.*$': 'import \1',
            \   }
            \ ]

    augroup END

    augroup PreciseTrimWhiteSpace
        autocmd!
        autocmd InsertLeave * call PreciseTrimWhiteSpace()
    augroup end

    augroup vimrc     " Source vim configuration upon save
        autocmd!
        autocmd! BufWritePost ~/.vim/vimrc source % | echom "Reloaded vimrc" | redraw
        autocmd! BufWritePost ~/.vimfiles/vimrc source % | echom "Reloaded vimrc" | redraw
        autocmd! BufWritePost $MYVIMRC source % | echom "Reloaded vimrc" | redraw
        autocmd! BufWritePost $MYVIMRC source % | echom "Reloaded vimrc" | redraw
        autocmd! BufWritePost $MYGVIMRC if has('gui_running') | so % | echom "Reloaded " . $MYGVIMRC | endif | redraw
    augroup END
endif

function! PreciseTrimWhiteSpace()
  " We need to save the view because the substitute command might
  " or might not move the cursor, depending on whether it finds
  " any whitespace.
  let saved_view = winsaveview()

  " Remove white space. Ignore "not found" errors. Don't change jumplist.
  keepjumps '[,']s/\s\+$//e
  keepjumps '[,']s/=$/= /e

  " Move cursor back if necessary.
  call winrestview(saved_view)
endfunction


if has('mac')
    " hash instead of pound
    inoremap £ #
    nnoremap £ #
    cnoremap £ #

    " alt-3
    inoremap <M-3> £
    cnoremap <M-3> £

    " for replace
    nnoremap r£ r#
endif

" LEADER MAPPINGS
" ---------------
"
" \t = new tab
noremap <Leader>t :tabnew<CR>

" \T = close tab
noremap <Leader>T :tabclose<CR>

" \O = only this tab
noremap <Leader>O :tabonly<CR>

" \w = split window search cword
nnoremap <Leader>w :let @/=expand("<cword>")<Bar>split<Bar>normal n<CR>

" \W = split window search cword + boundary
nnoremap <Leader>W :let @/='\<'.expand("<cword>").'\>'<Bar>split<Bar>normal n<CR>

" \xf = format xml
if executable('xml_pp')
    " xml_pp = xml pretty print from XML::Twig
    map <Leader>xf :silent %!xml_pp - <CR>
    vmap <Leader>xf :!xml_pp - <CR>
endif

" \hf = format html
if executable('html_pp')
    " html_pp = html pretty print using Beautiful Soup
    map <Leader>hf :silent %!html_pp - <CR>
    vmap <Leader>hf :!html_pp - <CR>
endif

if executable('python')
    " \jf = format json
    map <Leader>jf :silent %!python3 -c 'import sys,json;print(json.dumps(json.loads(sys.stdin.read()),sort_keys=True,indent=4))' - <CR><CR>:setf json<CR>
    vmap <Leader>jf :!python3 -c 'import sys,json;print(json.dumps(json.loads(sys.stdin.read()),sort_keys=True,indent=4))' - <CR><CR>

    " \pf = format json
    map <Leader>pf :silent %!python3 -c 'import sys, pprint; pprint.PrettyPrinter(indent=2, compact=True).pprint(eval(sys.stdin.read()))' - <CR><CR>
    vmap <Leader>pf :!python3 -c 'import sys, pprint; pprint.PrettyPrinter(indent=2).pprint(eval(sys.stdin.read()))' - <CR><CR>
endif

" shift-F1 - help current word
nnoremap <S-F1> :execute 'help ' . expand('<cword>')<CR>


" Quoting

" \qs = quote single
vnoremap <Leader>qs :norm yss'<CR>

" \qd = quote double
vnoremap <Leader>qd :norm yss"<CR>

" \s, = quote single with comma
vnoremap <Leader>s, :norm yss'A,<CR>

" \d, = quote double with comma
vnoremap <Leader>d, :norm yss"A,<CR>

" \dc = remove trailing comma
nnoremap <Leader>dc :.s/,\s*$//<CR>
vnoremap <Leader>dc :s/,\s*$//<CR>

" \, = comma separate
vnoremap <Leader>, :normal A,<CR>

"" TODO: check on X-windows, need to support primary/secondary?

" \ye = copy EOL into clipboard
nnoremap <Leader>ye "*y$

" \yy = copy EOL into clipboard
nnoremap <Leader>yy m`^"*y$``

" \yp = copy inner paragraph into clipboard
nnoremap <Leader>yp "*yip

" \y = copy into clipboard
vnoremap <Leader>y "*y

" \qf = Quick fix open
noremap <Leader>qf :copen<CR>

" \qc = Quick fix close
noremap <Leader>qc :cclose<CR>

" \lf = Location open
noremap <Leader>lf :lopen<CR>

" \lc = Location close
noremap <Leader>lc :lclose<CR>

" \dw = remove trailing whitespace
nnoremap <Leader>dw :%s/\s\+$//g<CR>
vnoremap <Leader>dw :s/\s\+$//g<CR>

" \- = ruler
nnoremap <Leader>- o<Esc>80a-<Esc>

" \= ruler
nnoremap <Leader>= o<Esc>80a=<Esc>

" \v = new vertical split
nnoremap <Leader>v :vnew<CR>

" \h = new horizontal split
nnoremap <Leader>h :new<CR>

" \rm = Remove file + confirm
nnoremap <Leader>rm :!rm -i %<CR>

" \pw = Pwd
nnoremap <Leader>pw :pwd<CR>

" \wd = change working directory to current buffer
nnoremap <Leader>wd :execute 'cd ' . expand('%:h')<bar>:pwd<CR>

" \ss - save all
nnoremap <Leader>ss :wa<CR>

" \us = Unique sort whole file
if has('mac')
    nnoremap <Leader>us :%!gsort -u<CR>
    vnoremap <Leader>us :'<,'>!gsort -u<CR>
else
    nnoremap <Leader>us :%!sort -u<CR>
    vnoremap <Leader>us :'<,'>!sort -u<CR>
endif

" \vs = Visual sort
vnoremap <Leader>vs :'<,'>sort<CR>

" \vrc - open vimrc
if has('unix')
    nnoremap <Leader>vrc :tabedit ~/.vim/vimrc<CR>
else
    nnoremap <Leader>vrc :tabedit ~/.vimfiles/vimrc<CR>
endif

" \vso = reload vimrc manually
nnoremap <Leader>vso :so $MYVIMRC<CR>:echo "sourced $MYVIMRC"<CR>

" \sb = shebang for bash
nnoremap <Leader>sb :normal 1GO<ESC>:.!which env<CR>I#!<ESC>A bash<ESC>

" Vgrep = Ack '^\s*".*<args>.*=' vimrc
command! -nargs=1 Vgrep :execute ":Ack '^\\s*\".*" . substitute('<args>', '\\', '\\\\', 'g') . "' " . g:_vimrc

" ReadUrl = download + edit the url
if executable('curl')
    command! -nargs=1 ReadUrl :r!curl -s '<args>'
endif

" \ms = messages
nnoremap <Leader>ms :messages<CR>

" \mc = messages clear
nnoremap <Leader>mc :messages clear<CR>


" COMMAND MAPPINGS
" ----------------

" ctrl-a = begin of line (emacs)
cnoremap <C-A> <Home>

" ctrl-e = begin of line (emacs)
cnoremap <C-E> <End>

" ctrl-k = delete to eol (emacs)
cnoremap <c-k> <C-\>estrpart(getcmdline(),0,getcmdpos()-1)<CR>

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
nnoremap <C-N> :next<CR>

" ctrl-p = prev file
nnoremap <C-P> :prev<CR>

" Buffer switching
nmap L ]b
nmap H [b

" Buffer delete
" TODO: don't close on error when not written
" Q = delete buffer unless modified
nmap <silent> Q :bp<CR>:bd #<CR>

" alt-q = delete buffer unconditionally
nmap <silent> <M-q> :bp<CR>:bd! #<CR>

" ctrl-alt-q = delete buffer unconditionally + close tab
nmap <silent> <C-M-q> :bd!<CR>:tabclose<CR>


" Window switching

" ctrl-k = up window
nmap <silent> <c-k> :wincmd k<CR>

" ctrl-k = up window
nmap <silent> <c-j> :wincmd j<CR>

" ctrl-k = up window
nmap <silent> <c-h> :wincmd h<CR>

" ctrl-k = up window
nmap <silent> <c-l> :wincmd l<CR>

" copypath
" \cd = copy directory/path
" \cf = copy fullpath
" \cv = copy filename only
if has('win32')
    nmap <Leader>cd :let @+=substitute(expand("%:p:h"), "/", "\\", "g")<CR>
    nmap <Leader>cf :let @+=substitute(expand("%:p"), "/", "\\", "g")<CR>
    nmap <Leader>cv :let @+=substitute(expand("%"), "/", "\\", "g")<CR>
elseif has('unix')
    nmap <Leader>cd :let @+=expand("%:p:h")<CR>
    nmap <Leader>cf :let @+=expand("%:p")<CR>
    nmap <Leader>cv :let @+=expand("%")<CR>
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
    let cmd = ':set '.a:opt.'! \| set '.a:opt."?\<CR>"
    exec 'nnoremap '.a:key.' '.cmd
    exec 'inoremap '.a:key." \<C-O>".cmd
endfunction
command! -nargs=+ MapToggle call MapToggle(<f-args>)

function! CheckSyncDir()
    " TODO: set to env var
    let buffDir = expand('%:p:h')
    if match(buffDir, '\c\/sync\/') > -1
        setlocal noswapfile
    endif
endfunction

" Display-altering option toggles
" F2 = toggle spell
MapToggle <F2> spell

" \ws = toggle wrapscan
MapToggle <Leader>ws wrapscan

" F6 = syntax on/off
map <F6> :if exists("syntax_on") <Bar> syntax off <Bar> else <Bar> syntax enable <Bar> endif <CR>

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

" F12 = toggle paste
MapToggle <F12> paste
set pastetoggle=<F12>

if !&diff
    " \ac = toggle autochdir
    MapToggle <Leader>ac autochdir
endif

if has('mac')
    " \F = toggle fullscreen
    MapToggle <Leader>F fullscreen
endif

" \cc = toggle cursorcolumn
MapToggle <Leader>cc cursorcolumn


" search Sync
" Ngrep = search command wiki
command! -nargs=1 Ngrep Ack "<args>" ~/sync/stuff/commands/*

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
command! -complete=customlist,GlobCommandsDir -nargs=1 Nopen :call NerdWrap() <bar> tabedit ~/sync/stuff/commands/<args>

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
map <F3> :TagbarToggle<CR>

" Fugitive
" --------
" \cg = copy git path relative
nnoremap <Leader>cg :let @+=(fugitive#extract_git_dir('.') !=# '' ? FugitivePath(@%, '') : '')<CR>

" \gd = Gvdiff
nnoremap <Leader>gd :Gvdiff<CR>

" \gs = Gstatus
nnoremap <Leader>gs :Gstatus<CR>

" NERDTree
" --------
let NERDTreeIgnore = ['\.pyc', '\.pyo', '^tags$', '__pycache__', 'node_modules']

" delete buffers after delete from tree
let NERDTreeAutoDeleteBuffer=1

" s = split horizontally
" v = split vertically
let NERDTreeMapOpenVSplit='v'
let NERDTreeMapOpenSplit='s'


" F4 = nerdtree open/focus
map <F4> :silent NERDTreeFocus<CR>

" shift F4 = nerdtree open
map <S-F4> :silent NERDTreeFind<CR>

" \F4 = close NerdTree
map <Leader><F4> :silent NERDTreeClose<CR>

" \\F4 = nerdtree toggle
map <Leader><Leader><F4> :silent NERDTreeToggle<CR>

" \ng = Open NerdTree to git root
map <Leader>ng :silent NERDTreeVCS<CR>


" prevent opening files inside the nerdtree window
function! NerdWrap() abort
    if (g:NERDTree.ExistsForBuf())
        if (winnr('$') == 1)
            call g:NERDTreeOpener._newVSplit()
        else
            execute 'wincmd w'
        endif
    endif
endfunction


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


" Ack
" ---
let g:ackprg = 'ag --vimgrep'

let g:ack_mappings = {
    \   'v':  '<C-W><CR><C-W>L<C-W>p<C-W>J<C-W>p',
    \   'gv': '<C-W><CR><C-W>L<C-W>p<C-W>J' 
    \ }

" \ak = Ack!
map <leader>ak :call NerdWrap()<CR> <bar> :Ack! 

" \aK = Ack! from file directory
map <leader>aK :call NerdWrap()<CR> <bar> :execute ':Ack! ' . input('Ack! ') . ' ' . expand('%:h')<CR>


" ALE
" ---
" by default ALE is off, use F5 to toggle
let g:ale_enabled = 0


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
nmap <F5> :ALEToggle<CR>
nmap <S-F5> :ALEToggleBuffer<CR>
imap <F5> <C-o>:ALEToggle<CR>
vmap <F5> :ALEToggle<CR>

" ctrl-F5 = ALEFix
nmap <C-F5> :ALEFix<CR>

" ]g = next ALE issue
nnoremap ]g :ALENext<CR>

" [g = prev ALE issue
nnoremap [g :ALEPrevious<CR>


" Switch
" ------
" \gs = Switch

" 1 - dd/mm/yyyy to isodate
" 2 - 'X \w+ Y' to 'Y \w+ X'
let g:switch_custom_definitions =
    \ [
    \   {
    \       '\(\d\+\)[/.-]\(\d\+\)[/.-]\(\d\+\)': '\3-\2-\1',
    \       '\(\w\+\)\(\s\+\w\+\s\+\)\(\w\+\)': '\3\2\1'
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

" LeaderF
" -------
" \b = Fuzzy Buffer
"
let g:Lf_MruMaxFiles = 1000
let g:Lf_MruFileExclude = ['*/tmp/*']
let g:Lf_FollowLinks = 1
let g:Lf_HistoryNumber = &history
let g:Lf_PythonVersion = 3
let g:Lf_ShortcutF = ''
let g:Lf_WildIgnore = {
    \   'dir': ['.svn','.git','.hg', 'node_modules'],
    \   'file': ['*.sw?','~$*','*.bak','*.exe','*.o','*.so','*.py[co]']
    \ }


" \f = Fuzzy MRU
nmap <Leader>f :call NerdWrap() <bar> LeaderfMru<CR>

" \p = Fuzzy files
nmap <Leader>p :call NerdWrap() <bar> LeaderfFile<CR>

" Commentary
" ----------

" gcaf = comment whole file
nmap gcaf gggcG


" ===========
" End Plugins
" ===========

syntax enable

if filereadable(glob('~/.vim/myextras.vim'))
    " put work stuff in here
    :source ~/.vim/myextras.vim
endif
