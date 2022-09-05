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
- coc-settings.json
- gitconfig
- init.vim
- tmux.conf
- vimrc
- zshrc

eg. to setup `coc-settings.json`, `gitconfig`, `init.vim`, `tmux.conf`, `vimrc` and `zshrc`, run:

    python setup_home_folder_dotfiles.py coc-settings.json gitconfig init.vim tmux.conf vimrc zshrc


## Installing vim plugins

Run:
```
./install-vim-plugins
```

Then start vim and run:
```
:GoInstallBinaries
```


## Install nvr

Run the [provision-ubuntu-ansible](https://github.com/yanhan/provision-ubuntu-ansible) repo to install the libffi6 library.

Then run:
```
pip3 install --user neovim-remote
```


## LICENSE

[3-Clause BSD License](/LICENSE), Copyright (c) 2019 Yan Han Pang
