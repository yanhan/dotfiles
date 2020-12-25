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
- init.vim
- tmux.conf
- vimrc
- zshrc

eg. to setup `gitconfig`, `init.vim`, `tmux.conf`, `vimrc` and `zshrc`, run:

    python setup_home_folder_dotfiles.py gitconfig init.vim tmux.conf vimrc zshrc


## haskell-vim-now setup

These files:

- [plugins.vim](plugins.vim)
- [vimrc.local.pre](vimrc.local.pre)

should be copied to `~/.config/haskell-vim-now` in a setup that uses [haskell-vim-now](https://github.com/begriffs/haskell-vim-now)


## Installing vim plugins

Run:
```
./install-vim-plugins
```

Then start vim and run:
```
:GoInstallBinaries
```


## LICENSE

[3-Clause BSD License](/LICENSE), Copyright (c) 2019 Yan Han Pang
