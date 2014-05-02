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

### Vim solarized setup for Gnome Terminal

[Solarized](https://github.com/altercation/solarized) is a popular color scheme
for text editors. This section assumes that you will be setting it up for
**Gnome Terminal**.

We will be using [sigurda's gnome-terminal-colors-solarized git repository](https://github.com/sigurdga/gnome-terminal-colors-solarized).
Follow the setup instructions there and you should be fine.
