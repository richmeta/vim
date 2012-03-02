" NOTE: more VIMRC => plugin bindings in commands in
" .vim/after/plugin/postplugin.vim
" 
"

" 'vim -u NONE' skips loading plugins.

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
set statusline=%F%m%r%h%w[%L][%{&ff}]%y[%p%%][%04l,%04v]
set winminheight=0
set gdefault
set shiftround
set showcmd

"set sidescrolloff=10

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

set grepprg=ack
noremap <Leader>t :tabnew<CR>
map Y y$
set matchpairs+=<:>
nnoremap <C-N> :next<CR>
nnoremap <C-P> :prev<CR>
nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprevious<CR>

"open window on current word
nnoremap \w :let @/=expand("<cword>")<Bar>split<Bar>normal n<CR>
nnoremap \W :let @/='\<'.expand("<cword>").'\>'<Bar>split<Bar>normal n<CR>

" todo - test if xmllint exists
" todo - test if file is empty
autocmd FileType xml exe ":silent %!xmllint --format --recover - "
autocmd FileType xsd exe ":silent %!xmllint --format --recover - "
autocmd FileType python set tabstop=4 shiftwidth=4

" prevent delimitmate from loading
autocmd FileType xhtml,xml let b:loaded_delimitMate = 1

unmap <C-y>
nmap <C-up> <C-y>
imap <C-up> <C-o><C-y>
nmap <C-down> <C-e>
imap <C-down> <C-o><C-e>

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

map Q <Nop>
map K <Nop>
map K <Nop>

" copypath
" \xx = copy fullpath
"" \xs = copy filename
if has('win32')
  nmap <Leader>xx :let @*=substitute(expand("%:p"), "/", "\\", "g")<CR>
  nmap <Leader>xs :let @*=substitute(expand("%"), "/", "\\", "g")<CR>
elseif has('unix')
  nmap <Leader>xx :let @*=expand("%:p")<CR>
  nmap <Leader>xs :let @*=expand("%")<CR>
endif
" sudo write 
if has('unix')
	command! -bar -nargs=0 W  silent! exec "write !sudo tee % >/dev/null"  | silent! edit!
	command! -bar -nargs=0 WX silent! exec "write !chmod a+x % >/dev/null" | silent! edit!
elseif has('win32')
	command! -bar -nargs=0 WR silent! exec "write !attrib -r %" | silent! edit!
endif
" Map key to toggle opt
function MapToggle(key, opt)
  let cmd = ':set '.a:opt.'! \| set '.a:opt."?\<CR>"
  exec 'nnoremap '.a:key.' '.cmd
  exec 'inoremap '.a:key." \<C-O>".cmd
endfunction
command -nargs=+ MapToggle call MapToggle(<f-args>)

map <F6> :if exists("syntax_on") <Bar> syntax off <Bar> else <Bar> syntax enable <Bar> endif <CR>

" Display-altering option toggles
MapToggle <F7> hlsearch
MapToggle <F8> wrap
MapToggle <F9> list

" Behavior-altering option toggles
MapToggle <F10> scrollbind
MapToggle <F11> ignorecase
MapToggle <F12> paste
set pastetoggle=<F12>

" colorscheme switching
map <Leader>c<Right> :call NextColorScheme()<CR> :colorscheme<CR>
map <Leader>c<Left>  :call PreviousColorScheme()<CR> :colorscheme<CR>
map <Leader>c<Up>    :call RandomColorScheme()<CR> :colorscheme<CR>
map <Leader>c<Del>   :call RemoveCurrentColorScheme()<CR> :colorscheme<CR>

" perl support (TODO: not working)
let g:perl_compiler_force_warnings = 0    " -w not -W
autocmd BufNewFile,BufRead *.pl compiler! perl

" perltidy
nmap <Leader>pt :%!perltidy<CR>
vmap <Leader>pt :!perltidy<CR>

syntax enable
