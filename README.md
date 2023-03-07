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


## Neovim

Run the following:
```
if [ ! -d "${HOME}"/.config/nvim ]
then
  mkdir -v "${HOME}"/.config/nvim
fi

cp init.lua "${HOME}"/.config/nvim
# Intention is to override "${HOME}"/.config/nvim/lua folder with nvim-lua
cp -R nvim-lua "${HOME}"/.config/nvim/lua
```


## Installing vim plugins

Run:
```
./install-vim-plugins
```

Then start vim and run:
```
:GoInstallBinaries
:CocInstall coc-tsserver
```


## Install nvr

Run the [provision-ubuntu-ansible](https://github.com/yanhan/provision-ubuntu-ansible) repo to install the libffi6 library.

Then run:
```
pip3 install --user neovim-remote
```


## For Windows

Currently, we only support setting up neovim.

Download the C++ Runtime framework packages for Desktop bridge here: https://learn.microsoft.com/en-gb/troubleshoot/developer/visualstudio/cpp/libraries/c-runtime-packages-desktop-bridge#how-to-install-and-update-desktop-framework-packages

Specifically, the `Microsoft.VCLibs.x64.14.00.Desktop.appx`. It is required for microsoft-windows-terminal

Then install it using:
```
Add-AppxPackage .\Microsoft.VCLibs.x64.14.00.Desktop.appx
```

First, run Powershell as administrator and run this:
```
& .\bootstrap.ps1
```

Then, open a normal Powershell and run the following to install vim plugins:
```
& .\inst.ps1
```


## References

Converting to Lua and use of LSP zero is inspired by: [https://www.youtube.com/watch?v=w7i4amO_zaE](https://www.youtube.com/watch?v=w7i4amO_zaE)


## LICENSE

[3-Clause BSD License](/LICENSE), Copyright (c) 2019 Yan Han Pang
