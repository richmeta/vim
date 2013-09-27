" NOTE: more VIMRC => plugin bindings in commands in
" .vim/after/plugin/postplugin.vim
" 
"

" 'vim -u NONE' skips loading plugins.
"
"
set nocompatible

call pathogen#infect()
call pathogen#helptags()



" enable ctrl-c, ctrl-v, ctrl-a
source $VIMRUNTIME/mswin.vim
" enable selectmode and mouse behaviour
behave mswin
set hidden
set nobackup
set tabstop=2
set softtabstop=2
set nowrap
set novisualbell
set noerrorbells
set expandtab
set shiftwidth=2
set ignorecase
set smartcase
set nohls
set autochdir
set autowrite
set modelines=0
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
set iskeyword+=-,.,\\,/



" todo: call random if plugin is loaded
colorscheme torte

if has("autocmd")
  filetype plugin indent on
  
  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
  \ if line("'\"") > 1 && line("'\"") <= line("$") |
  \   exe "normal! g`\"" |
  \ endif

  augroup END
endif

" LEADER MAPPINGS
" ---------------
"
" \p = ctrlp
" \t = new tab
noremap <Leader>t :tabnew<CR>

" \pt = perltidy
nmap <Leader>pt :%!perltidy<CR>
vmap <Leader>pt :!perltidy<CR>

" \w 
" open window on current word
nnoremap <Leader>w :let @/=expand("<cword>")<Bar>split<Bar>normal n<CR>
nnoremap <Leader>W :let @/='\<'.expand("<cword>").'\>'<Bar>split<Bar>normal n<CR>

" \xf = re-format xml 
" todo - test if xmllint exists
if executable('xmllint')
  map <Leader>xf :silent %!xmllint --format --recover - <CR>
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

" \cY = copy to end of line ( i.e. without CR)
nnoremap <Leader>cY "+y$

" \u = CtrlPMRU 
map <Leader>u :CtrlPMRU<CR>


" OTHER MAPPINGS
" --------------
"
" Y = yank to EOL
map Y y$

" Ctrl-E/Ctrl-Y scroll up/down
unmap <C-y>
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
nmap <silent> Q :bd<CR>
nmap <silent> <A-q> :bd!<CR>

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
" todo \cd = copy file's dir
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
	command! -bar -nargs=0 W  silent! exec "write !sudo tee % >/dev/null"  | silent! edit!
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
command -nargs=+ MapToggle call MapToggle(<f-args>)

map <F6> :if exists("syntax_on") <Bar> syntax off <Bar> else <Bar> syntax enable <Bar> endif <CR>

" Display-altering option toggles
MapToggle <F5> wrapscan
MapToggle <F7> hlsearch
MapToggle <F8> wrap
MapToggle <F9> list

" Behavior-altering option toggles
MapToggle <F10> scrollbind
MapToggle <F11> ignorecase
MapToggle <F12> paste
set pastetoggle=<F12>

" perl support 
" disable incremental searching 
" TODO: this is global, better to only disable 'i' for perl
set complete=.,w,b,u,t

" PLUGIN SETTINGS 
" ---------------
"
let g:perl_compiler_force_warnings = 0    " -w not -W

" ctrlp = \p
" ( ctrlpmru = \u )
let g:ctrlp_map = '<Leader>p'

" PRIVATE FUNCTIONS 
" -----------------
"

" [reg]\p | [reg]\P to put at BOL or EOL
" ( where [reg] includes dquote  eg "w\p )
function! XOL_put(eol)
  if a:eol
    let location = "$"
    let p = "p"
  else
    let location = "0"
    let p = "P"
  endif
  let cmd = 'normal ' . location . v:count1 . '"' . v:register . p
  execute cmd
endfunction

nnoremap <silent> <leader>p :call XOL_put(1)<CR>
nnoremap <silent> <leader>P :call XOL_put(0)<CR>

syntax enable

" TODO:
" add toggle for wrapscan
