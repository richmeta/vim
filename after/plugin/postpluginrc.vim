" this file must be in .vim/after/plugin/ directory
if exists("loaded_nerd_tree")
  map <F4> :NERDTreeToggle<CR>
  map <S-F4> :NERDTreeFind<CR>

  let NERDTreeIgnore=['\.pyc','\.pyo','^tags$','__pycache__']
endif
