" NOTE: more VIMRC => plugin bindings in commands in
" .vim/after/plugin/postplugin.vim
" 
"

set nocompatible
filetype off

if isdirectory(expand("~/.vim/bundle/Vundle.vim"))
    set runtimepath+=~/.vim/bundle/Vundle.vim
elseif isdirectory(expand("~/vimfiles/bundle/Vundle.vim"))
    set runtimepath+=~/vimfiles/bundle/Vundle.vim
endif

" for fzf
if executable('fzf')
    set runtimepath+=/usr/local/opt/fzf
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
Bundle 'AndrewRadev/switch.vim'
Bundle 'fs111/pydoc.vim'
Bundle 'tomtom/tcomment_vim'
Bundle 'mhinz/vim-grepper'
Bundle 'xolox/vim-misc'
Bundle 'thinca/vim-localrc'
Bundle 'wellle/targets.vim'
Bundle 'flazz/vim-colorschemes'
Bundle 'junegunn/fzf.vim'
Bundle 'mileszs/ack.vim'
Bundle 'w0rp/ale'
Bundle 'tmhedberg/matchit'
Bundle 'tpope/vim-speeddating'
Bundle 'tpope/vim-abolish'
Bundle 'tpope/vim-jdaddy'
Bundle 'kshenoy/vim-signature'


" enable ctrl-c, ctrl-v, ctrl-a
source $VIMRUNTIME/mswin.vim
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
set grepprg=ack
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

        autocmd BufWinEnter,BufRead * :call CheckDropbox()
    augroup END

    autocmd BufNewFile,BufRead *.txt call SetPartialSyntax()
endif

if has('mac')
    " use pound symbol instead of awkward hash
    inoremap # £
    inoremap £ #
    nnoremap £ #
    cnoremap £ #
endif

" SYNTAX BLOCKS
" -------------
"    http://vim.wikia.com/wiki/Different_syntax_highlighting_within_regions_of_a_file
"   ( used for code inside txt files etc )

function! SetPartialSyntax()
    syntax include @JS syntax/javascript.vim
    syntax region jsSnip matchgroup=Snip start="@begin=js@" end="@end=js@" contains=@JS
    " TODO: doesn't seem to work for python
    " syntax include @PYTHON syntax/python.vim
    " syntax region pySnip matchgroup=Snip start="@begin=py@" end="@end=py@" contains=@PYTHON
    hi link Snip SpecialComment
endfunction

" LEADER MAPPINGS
" ---------------
"
" \t = new tab
noremap <Leader>t :tabnew<CR>

" \pt = perltidy
if executable('perltidy')
  nmap <Leader>pt :%!perltidy<CR>
  vmap <Leader>pt :!perltidy<CR>
endif

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
if executable('html_pp.py')
  " html_pp = html pretty print using Beautiful Soup
  map <Leader>hf :silent %!html_pp.py - <CR>
  vmap <Leader>hf :!html_pp.py - <CR>
endif

" \jf = format json
if executable('python')
  " map <Leader>jf :silent %!python3 -mjson.tool<CR>
  map <Leader>jf :silent %!python3 -c 'import sys,json;print(json.dumps(json.loads(sys.stdin.read()),sort_keys=True,indent=4))' - <CR><CR>
  vmap <Leader>jf :!python3 -c 'import sys,json;print(json.dumps(json.loads(sys.stdin.read()),sort_keys=True,indent=4))' - <CR><CR>

  map <Leader>pf :silent %!python3 -c 'import sys, pprint; pprint.PrettyPrinter(indent=2, compact=True).pprint(eval(sys.stdin.read()))' - <CR><CR> 
  vmap <Leader>pf :!python3 -c 'import sys, pprint; pprint.PrettyPrinter(indent=2).pprint(eval(sys.stdin.read()))' - <CR><CR> 
endif



" \ds = time stamp
" \dd = date only
" \dt = time only
nnoremap <Leader>ds "=strftime("%d/%m/%Y %H:%M")<CR>P
inoremap <C-D>s <C-R>=strftime("%d/%m/%Y %H:%M")<CR>
nnoremap <Leader>dd "=strftime("%d/%m/%Y")<CR>P
inoremap <C-D>d <C-R>=strftime("%d/%m/%Y")<CR>
nnoremap <Leader>dt "=strftime("%H:%M")<CR>P
inoremap <C-D>t <C-R>=strftime("%H:%M")<CR>

" quoting:  
"    , = with trailing comma
"    <leader> = without
"         
" \dq = double quote
" \sq = single quote 
" \ddq = delete double quote
" \dsq = delete single quote 
" ,dq = double quote with commas
" ,sq = single quote with commas
" ,ddq = delete double quote incl comma
" ,dsq = delete single quote incl comma
vmap <Leader>dq :normal yss"<CR>
vmap <Leader>sq :normal yss'<CR>
vmap <Leader>ddq :normal ds"<CR>
vmap <Leader>dsq :normal ds'<CR>
vmap ,dq :normal yss"A,<CR>
vmap ,sq :normal yss'A,<CR>
vmap ,ddq :normal ds"$x<CR>
vmap ,dsq :normal ds'$x<CR>

" \cl = comma separate lines
vmap <Leader>cl :normal A,<CR>

" \yy = copy to end of line to clipboard ( i.e. without CR)
nnoremap <Leader>yy "*y$

" \p = FILES, \u = FZF MRU, \b = FZF Buffer
nnoremap <Leader>p :Files<CR>
nnoremap <Leader>u :History<CR>
nnoremap <Leader>b :Buffers<CR>

" \qf = Quick fix open
" \qc = Quick fix close
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

" Switch
nnoremap <Leader>sw :Switch<CR>

" COMMAND MAPPINGS
" ----------------
cnoremap <C-A> <Home>
cnoremap <C-E> <End>

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
nmap <silent> Q :bp<CR>:bd #<CR>
if has("mac")
    nmap <silent> œ :bp<CR>:bd! #<CR>
else
    nmap <silent> <M-q> :bp<CR>:bd! #<CR>
endif

" Window switching
nmap <silent> <c-k> :wincmd k<CR>
nmap <silent> <c-j> :wincmd j<CR>
nmap <silent> <c-h> :wincmd h<CR>
nmap <silent> <c-l> :wincmd l<CR>

" python sw=4
autocmd FileType python set tabstop=4 shiftwidth=4

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
  nmap <Leader>cg :let @+=(fugitive#extract_git_dir('.') !=# '' ? fugitive#buffer().path() : '')<CR>
endif

" sudo write 
if has('unix')
	command! -bar -nargs=0 W  echo "Password: " | silent! exec "write !sudo tee % >/dev/null"  | silent! edit!
	command! -bar -nargs=0 WX silent! exec "write !chmod a+x % >/dev/null" | silent! edit!
elseif has('win32')
	command! -bar -nargs=0 WR silent! exec "write !attrib -r %" | silent! edit!
endif

" Map key to toggle opt
function! MapToggle(key, opt)
  let cmd = ':set '.a:opt.'! \| set '.a:opt."?\<CR>"
  exec 'nnoremap '.a:key.' '.cmd
  exec 'inoremap '.a:key." \<C-O>".cmd
endfunction
command! -nargs=+ MapToggle call MapToggle(<f-args>)

function! CheckDropbox()
  let buffDir = expand('%:p:h')
  if match(buffDir, '\c\/dropbox') > -1
    setlocal noswapfile
  endif
endfunction

" syntax on/off
map <F6> :if exists("syntax_on") <Bar> syntax off <Bar> else <Bar> syntax enable <Bar> endif <CR>

" tagbar
map <F3> :TagbarToggle<CR>

" ALE
nmap <S-F5> :ALEToggle<CR>
imap <S-F5> <C-o>:ALEToggle<CR>
vmap <S-F5> :ALEToggle<CR>


" Display-altering option toggles
MapToggle <F2> spell
MapToggle <F5> wrapscan
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

MapToggle <Leader>f fullscreen

" perl support 
if has('win32') && executable('perl')
  " set complete=.,w,b,u,t
  " disable incremental searching (only a problem on windows)
  set complete-=i
endif

" search dropbox 
command! -nargs=1 Ngrep Ag "<args>" ~/Dropbox/commands/*
command! -nargs=1 Nopen edit ~/Dropbox/commands/<args>


" PLUGIN SETTINGS 
" ---------------

" nerdtree overrides
" s = split horizontally (not vertically [NT default])
" v = split vertically (not i=horizontally)(
let NERDTreeMapOpenVSplit='v'
let NERDTreeMapOpenSplit='s'


" ALE
" -----------
" python: needs flake8
"   ignore errors/warnings:
"    E501 line too long
"    W391 blank line at end of file 
"    F403 unabled to detect undefined names
let g:ale_python_flake8_options = '--ignore=E501,E731,W391,F403'
let g:ale_linters = {
\   'javascript': ['eslint'],
\   'python': ['flake8'],
\}

syntax enable

if filereadable("myextras.vim")
  :source myextras.vim
endif

set dictionary=~/.vim/dict/dict.txt
