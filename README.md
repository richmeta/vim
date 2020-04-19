# Linux/Macos setup
* Clone to ~/.vim
* Run `install.sh`

which does the following:

* Adds symlinks
    * `ln -s ~/.vim/vimrc ~/.vimrc`
    * `ln -s ~/.vim/gvimrc ~/.gvimrc`
* Installs [vim-plug](https://github.com/junegunn/vim-plug)
* Install Plugins

# Windows manual setup
Create the Symlinks:
`cd C:\Program Files\Vim`
`fsutil hardlink create _vimrc vimfiles\vimrc`
`fsutil hardlink create _gvimrc vimfiles\gvimrc`

Download plug.vim and put it in `vimfiles\autoload` directory.

Open vim and run :PlugInstall
