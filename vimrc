
set nocompatible
filetype off

if isdirectory(expand("~/.vim/bundle/Vundle.vim"))
    set runtimepath+=~/.vim/bundle/Vundle.vim
elseif isdirectory(expand("~/vimfiles/bundle/Vundle.vim"))
    set runtimepath+=~/vimfiles/bundle/Vundle.vim
endif

call vundle#rc()

" let Vundle manage Vundle, required
Bundle 'gmarik/Vundle.vim'
Bundle 'scrooloose/nerdtree'
Bundle 'vim-scripts/tlib'
Bundle 'MarcWeber/vim-addon-mw-utils'
Bundle 'godlygeek/tabular'
Bundle 'majutsushi/tagbar'
Bundle 'vim-scripts/CmdlineComplete'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-unimpaired'
Bundle 'SirVer/ultisnips'
Bundle 'honza/vim-snippets'
Bundle 'itchyny/lightline.vim'
Bundle 'tomtom/tcomment_vim'
Bundle 'xolox/vim-misc'
Bundle 'thinca/vim-localrc'
Bundle 'flazz/vim-colorschemes'
Bundle 'Yggdroot/LeaderF'
Bundle 'mileszs/ack.vim'
Bundle 'w0rp/ale'
Bundle 'tmhedberg/matchit'
Bundle 'isRuslan/vim-es6'
Bundle 'davidhalter/jedi-vim'
Plugin 'Glench/Vim-Jinja2-Syntax'

" use CTRL-A/CTRL-X to increment dates, times,
Bundle 'tpope/vim-speeddating'

" Show/Hide Marks
Bundle 'kshenoy/vim-signature'

" text objects
Bundle 'wellle/targets.vim'
Bundle 'jeetsukumaran/vim-pythonsense'

" Toggle words/expressions
Bundle 'AndrewRadev/switch.vim'


" enable ctrl-c, ctrl-v, ctrl-a
source $VIMRUNTIME/mswin.vim

" don't want gui find
unmap <C-F>

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
set nohls
if !&diff
    set autochdir
endif
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
if has('mac')
    set macmeta
endif
set tags=./tags;

set dictionary=~/.vim/dict/dict.txt

"
" Fav colorschemes
"  gruvbox
"  jellybeans
"  apprentice
"  feral
"  django
"  Green
"  candy
"  eclm_wombat
"  flatlandia
"  greyblue
"  vanzan_color
"  candy
"  phd
"  predawn
"  made_of_code
"  navajo-night
"  wombat
"  xterm16
"  pt_black
"  oceandeep
"  TODO: function random colorscheme from this list

if &term == "win32"
  " console vim, |lucius| doesn't support console
  colorscheme torte
else
  " gvim
  colorscheme lucius
endif

if has("autocmd")
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
        autocmd FileType python set ts=4 sw=4

        autocmd FileType python let b:switch_custom_definitions = 
            \ [
            \   {
            \       '\(\k\+\)=\([^),]\+\)': '''\1'': \2',
            \       '[''"]\(\k\+\)[''"]:\s*\([^},]\+\)': '\1=\2'
            \   }
            \ ]

    augroup END

    augroup vimrc     " Source vim configuration upon save
        autocmd!
        autocmd! BufWritePost $MYVIMRC source % | echom "Reloaded " . $MYVIMRC | redraw
        autocmd! BufWritePost $MYGVIMRC if has('gui_running') | so % | echom "Reloaded " . $MYGVIMRC | endif | redraw
    augroup END
endif


if has('mac')
    " hash instead of pound
    inoremap £ #
    nnoremap £ #
    cnoremap £ #

    " alt-3
    inoremap <M-3> £
    cnoremap <M-3> £
endif

" LEADER MAPPINGS
" ---------------
"
" \t = new tab
noremap <Leader>t :tabnew<CR>

" \w
" open window on current word
nnoremap <Leader>w :let @/=expand("<cword>")<Bar>split<Bar>normal n<CR>
nnoremap <Leader>W :let @/='\<'.expand("<cword>").'\>'<Bar>split<Bar>normal n<CR>

" \xf = re-format xml
if executable('xml_pp')
  " xml_pp = xml pretty print from XML::Twig
  map <Leader>xf :silent %!xml_pp -- <CR>
  vmap <Leader>xf :!xml_pp -- <CR>
endif

" \hf = re-format html
if executable('html_pp')
  " html_pp = html pretty print using Beautiful Soup
  map <Leader>hf :silent %!html_pp - <CR>
  vmap <Leader>hf :!html_pp - <CR>
endif

" \jf = format json
" \pf = format json
if executable('python')
  map <Leader>jf :silent %!python3 -c 'import sys,json;print(json.dumps(json.loads(sys.stdin.read()),sort_keys=True,indent=4))' - <CR><CR>:setf json<CR>
  vmap <Leader>jf :!python3 -c 'import sys,json;print(json.dumps(json.loads(sys.stdin.read()),sort_keys=True,indent=4))' - <CR><CR>

  map <Leader>pf :silent %!python3 -c 'import sys, pprint; pprint.PrettyPrinter(indent=2, compact=True).pprint(eval(sys.stdin.read()))' - <CR><CR>
  vmap <Leader>pf :!python3 -c 'import sys, pprint; pprint.PrettyPrinter(indent=2).pprint(eval(sys.stdin.read()))' - <CR><CR>
endif


" quoting:
" \qs = single
" \qd = double
" \s, = single with comma
" \d, = double with comma
" \, = comma separate
vnoremap <Leader>qs :norm yss'<CR>
vnoremap <Leader>qd :norm yss"<CR>
vnoremap <Leader>s, :norm yss'A,<CR>
vnoremap <Leader>d, :norm yss"A,<CR>
vnoremap <Leader>, :normal A,<CR>

" \yy = copy to end of line to clipboard ( i.e. without CR)
nnoremap <Leader>yy "*y$

" \qf = Quick fix open
" \qc = Quick fix close
" TODO: toggle for Quick fix open/closed
noremap <Leader>qf :copen<CR>
noremap <Leader>qc :cclose<CR>

" \lf = Location open
" \lc = Location close
noremap <Leader>lf :lopen<CR>
noremap <Leader>lc :lclose<CR>

" \dw = remove trailing whitespace
nnoremap <Leader>dw :%s/\s\+$//g<CR>
vnoremap <Leader>dw :s/\s\+$//g<CR>

" \- \=  insert ruler using -
nnoremap <Leader>- o<Esc>80a-<Esc>
nnoremap <Leader>= o<Esc>80a=<Esc>

" \v - open new vertical split
nnoremap <Leader>v :vnew<CR>

" \h - open new horizontal split
nnoremap <Leader>h :new<CR>

" \rm - Remove file (confirm)
nnoremap <Leader>rm :!rm -i %<CR>

" \pw - Pwd
nnoremap <Leader>pw :pwd<CR>

" \us - Unique sort whole file
if has("mac")
    nnoremap <Leader>us :%!gsort -u<CR>
    vnoremap <Leader>us :'<,'>!gsort -u<CR>
else
    nnoremap <Leader>us :%!sort -u<CR>
    vnoremap <Leader>us :'<,'>!sort -u<CR>
endif

" \vrc - open vimrc
nnoremap <Leader>vrc :e $MYVIMRC<CR>

" \vso - reload vimrc manually
nnoremap <Leader>vso :so $MYVIMRC<CR>:echo "sourced $MYVIMRC"<CR>

" \sb - shebang for bash -> TODO: move this to snippet
nnoremap <Leader>sb :normal 1GO<ESC>:.!which bash<CR>I#!<ESC>


" COMMAND MAPPINGS
" ----------------
cnoremap <C-A> <Home>
cnoremap <C-E> <End>

imap <c-e> <c-o>$
imap <c-a> <c-o>^

" OTHER MAPPINGS
" --------------
"
" Y = yank to EOL
map Y y$
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
nnoremap <C-N> :next<CR>
nnoremap <C-P> :prev<CR>

" Buffer switching
nmap L ]b
nmap H [b

" Buffer delete
nmap <silent> Q :bp<CR>:bd #<CR>
nmap <silent> <M-q> :bp<CR>:bd! #<CR>
nmap <silent> <C-M-q> :bd!<CR>:tabclose<CR>

" Window switching
nmap <silent> <c-k> :wincmd k<CR>
nmap <silent> <c-j> :wincmd j<CR>
nmap <silent> <c-h> :wincmd h<CR>
nmap <silent> <c-l> :wincmd l<CR>

" copypath
" \cf = fullpath,
" \cv = copy filename
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
	command! -bar -nargs=0 W echo "Password: " | silent! exec "write !sudo tee % >/dev/null"  | silent! edit!
	command! -bar -nargs=0 WX silent! | exec "write" | exec "write !chmod a+x % >/dev/null" | silent! edit!
elseif has('win32')
	command! -bar -nargs=0 WR silent! | exec "write" | exec "write !attrib -r %" | silent! edit!
endif

" Map key to toggle opt
function! MapToggle(key, opt)
  let cmd = ':set '.a:opt.'! \| set '.a:opt."?\<CR>"
  exec 'nnoremap '.a:key.' '.cmd
  exec 'inoremap '.a:key." \<C-O>".cmd
endfunction
command! -nargs=+ MapToggle call MapToggle(<f-args>)

function! CheckSyncDir()
  let buffDir = expand('%:p:h')
  if match(buffDir, '\c\/sync\/') > -1
    setlocal noswapfile
  endif
endfunction

" Display-altering option toggles
MapToggle <F2> spell
" <F3> - tagbar
" <F4> - nerdtree
MapToggle <F5> wrapscan

" syntax on/off
map <F6> :if exists("syntax_on") <Bar> syntax off <Bar> else <Bar> syntax enable <Bar> endif <CR>

MapToggle <F7> hlsearch
MapToggle <F8> wrap
MapToggle <F9> list
MapToggle <S-F8> number
MapToggle <S-F9> relativenumber

" Behavior-altering option toggles
MapToggle <F10> scrollbind
MapToggle <F11> ignorecase
MapToggle <F12> paste
set pastetoggle=<F12>

if !&diff
    " \ac - autochdir
    MapToggle <Leader>ac autochdir
endif


if has("mac")
    MapToggle <Leader>F fullscreen
endif


" search Sync
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
command! -complete=customlist,GlobCommandsDir -nargs=1 Nopen :call NerdWrap() <bar> edit ~/sync/stuff/commands/<args>

" ALT-N for tabs
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
map <F3> :TagbarToggle<CR>

" Fugative
" --------
nmap <Leader>cg :let @+=(fugitive#extract_git_dir('.') !=# '' ? FugitivePath(@%, '') : '')<CR>

" NERDTree
" --------
let NERDTreeIgnore = ['\.pyc', '\.pyo', '^tags$', '__pycache__', 'node_modules']

" delete buffers after delete from tree
let NERDTreeAutoDeleteBuffer=1

" s = split horizontally
" v = split vertically
let NERDTreeMapOpenVSplit='v'
let NERDTreeMapOpenSplit='s'

map <F4> :NERDTreeToggle<CR>
map <S-F4> :NERDTreeFind<CR>

" \nt - Focus to NerdTree
map <Leader>nt :NERDTreeFocus<CR>

" prevent opens using the nerdtree window
function! NerdWrap()
    if (g:NERDTree.ExistsForBuf())
        if (winnr('$') == 1)
            call g:NERDTreeOpener._newVSplit()
        else
            execute "wincmd w"
        endif
    endif
endfunction


" Lightline
" ---------

let g:lightline = {
    \   'active': {
    \       'left': [ [ 'mode', 'paste' ],
    \               [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
    \   },
    \   'component_function': {
    \       'gitbranch': 'fugitive#head',
    \   },
    \ }


" Ack
" ---
let g:ackprg = 'ag --vimgrep'

let g:ack_mappings = {
    \   'v':  '<C-W><CR><C-W>L<C-W>p<C-W>J<C-W>p',
    \   'gv': '<C-W><CR><C-W>L<C-W>p<C-W>J' 
    \ }


" ALE
" ---
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
    \ }

nmap <S-F5> :ALEToggle<CR>
imap <S-F5> <C-o>:ALEToggle<CR>
vmap <S-F5> :ALEToggle<CR>
nnoremap ]g :ALENext<CR>
nnoremap [g :ALEPrevious<CR>


" Switch
" ------
let g:switch_custom_definitions =
    \ [
    \   switch#NormalizedCase(['true', 'false']),
    \   {
    \       '\(\d\+\)[/.-]\(\d\+\)[/.-]\(\d\+\)': '\3-\2-\1'
    \   }
    \ ]

" Jedi
" -----
let g:jedi#popup_on_dot = 0
let g:jedi#use_splits_not_buffers = "bottom"


" UltiSnips
" ---------
let g:UltiSnipsUsePythonVersion = 3

" LeaderF
" -------
"
" \p = FILES
" \u = MRU
" \b = Buffer
let g:Lf_MruMaxFiles = 1000
let g:Lf_HistoryNumber = &history
let g:Lf_PythonVersion = 3
let g:Lf_ShortcutF = ''
let g:Lf_WildIgnore = {
    \   'dir': ['.svn','.git','.hg', 'node_modules'],
    \   'file': ['*.sw?','~$*','*.bak','*.exe','*.o','*.so','*.py[co]']
    \ }

nmap <Leader>u :call NerdWrap() <bar> LeaderfMru<CR>
nmap <Leader>p :call NerdWrap() <bar> LeaderfFile<CR>

" ===========
" End Plugins
" ===========

syntax enable

if filereadable("myextras.vim")
  :source myextras.vim
endif
