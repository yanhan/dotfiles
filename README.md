dotfiles
========

My dotfiles

## System requirements

- git >= 1.7.10 (for `[include]` syntax)

## Installation

Clone this repository to `$HOME/dotfiles`

    git clone https://github.com/yanhan/dotfiles.git

And run the `setup_home_folder_dotfiles.py` script with one or more of the
following args:

- bashrc
- gitconfig
- tmux.conf
- vimrc
- zshrc

eg. to setup the `gitconfig`, `tmux.conf`, `vimrc` and `zshrc`, run:

    python setup_home_folder_dotfiles.py gitconfig tmux.conf vimrc zshrc

## Vim setup

We are using [Vundle](https://github.com/gmarik/Vundle.vim) as our Vim plugin
manager. To setup Vundle:

    # Clone Vundle repository
    git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    cd ~/.vim/bundle/Vundle.vim
    # Checkout v0.10.2:
    git checkout v0.10.2
    # Install plugins
    vim +PluginInstall +qall

Now, launch `vim` and run `:PluginInstall`.
