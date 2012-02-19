" this file must be in .vim/after/plugin/ directory
if exists("loaded_nerd_tree")
	map <F4> :NERDTreeToggle<CR>

	if (glob("*.pyc") != "") 
		let NERDTreeIgnore=['\.pyc','\.pyo']
	endif
endif
