dotfiles
========

My dotfiles

## System requirements

- git >= 1.7.10 (for `[include]` syntax)

## Installation

Clone this repository to `$HOME/dotfiles`

    git clone https://github.com/yanhan/dotfiles.git

For the actual dotfiles in your `$HOME` folder, import / source the dotfiles
in this git repository. For example, your `$HOME/.bashrc` should contain this
line:

    [ -f $HOME/dotfiles/bashrc ] && . $HOME/dotfiles/bashrc

Your `$HOME/.vimrc` should contain this line:

    :source $HOME/dotfiles/vimrc

Similarly for the other dotfiles.

### Vim setup

We are using [Vundle](https://github.com/gmarik/Vundle.vim) as our Vim plugin
manager. To setup Vundle:

    git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim

Now, launch `vim` and run `:PluginInstall`.
