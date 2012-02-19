"call pathogen#runtime_append_all_bundles()
call pathogen#infect()
call pathogen#helptags()

set hidden
set novisualbell
set expandtab
set shiftwidth=2
set tabstop=2
syntax on

if has("autocmd")
  filetype plugin indent on
endif
