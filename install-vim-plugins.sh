#!/bin/bash

VIMCONFIG="${HOME}/.vim"
PACKAGE_PATH="${VIMCONFIG}/pack/bundle/start"
if [ ! -d "${PACKAGE_PATH}" ]; then
	mkdir -pv "${PACKAGE_PATH}"
fi

if [ ! -d ~/.fzf ]; then
	git clone git://github.com/junegunn/fzf.git ~/.fzf
fi
~/.fzf/install

pushd "${PACKAGE_PATH}"

if [ ! -d molokai ]; then
	git clone git://github.com/tomasr/molokai.git
fi

if [ ! -d nerdcommenter ]; then
	git clone git://github.com/preservim/nerdcommenter.git
fi

if [ ! -d nerdtree ]; then
	git clone git://github.com/preservim/nerdtree.git
fi

if [ ! -d vim-textobj-user ]; then
	git clone git://github.com/kana/vim-textobj-user.git
fi

if [ ! -d vim-textobj-entire ]; then
	git clone git://github.com/kana/vim-textobj-entire.git
fi

if [ ! -d vim-surround ]; then
	git clone git://github.com/tpope/vim-surround.git
fi

if [ ! -d vim-closetag ]; then
	git clone git://github.com/alvan/vim-closetag.git
fi

if [ ! -d vim-go ]; then
	git clone git://github.com/fatih/vim-go
fi

if [ ! -d fzf.vim ]; then
	git clone git://github.com/junegunn/fzf.vim
fi

if [ ! -d vim-projectionist ]; then
	git clone git://github.com/tpope/vim-projectionist.git
fi

if [ ! -d vim-obsession ]; then
	git clone git://github.com/tpope/vim-obsession.git
fi

### Mac specific

if [ ! -d vim-colors-solarized ]; then
	git clone git://github.com/altercation/vim-colors-solarized.git
fi

popd
