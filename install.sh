#!/usr/bin/env bash

[ ! -f ~/.vimrc ] && ln -sv ~/.vim/vimrc ~/.vimrc
[ ! -f ~/.gvimrc ] && ln -sv ~/.vim/gvimrc ~/.gvimrc


function yn() {
    local prompt="$1 [Yn]: "

    while true; do
        echo -n "$prompt"
        read yn
        case $yn in
            [Yy]* | "" )
                return 0;;
            [Nn]* )
                return 1;;
            * ) echo "Please answer yes or no.";;
        esac
    done
}

# vim-plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

if yn "install for neovim ?"; then
    curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    mkdir -p ~/.config/nvim
    cp ~/.vim/neovim_init.vim ~/.config/nvim/init.vim
    echo "now run: pip install pynvim"
fi

vim +PlugInstall +qall
