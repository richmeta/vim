" this file must be in .vim/after/plugin/ directory
if exists("loaded_nerd_tree")
	map <F4> :NERDTreeToggle<CR>
  map <F3> :NERDTreeFind<CR>

  let NERDTreeIgnore=['\.pyc','\.pyo','^tags$']
endif
