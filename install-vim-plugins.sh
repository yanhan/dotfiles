#!/bin/bash

PACKAGE_PATH="${HOME}/.local/share/nvim/site/pack/bundle/start"
if [ ! -d "${PACKAGE_PATH}" ]; then
	mkdir -pv "${PACKAGE_PATH}"
fi

if [ ! -d ~/.fzf ]; then
	git clone https://github.com/junegunn/fzf.git ~/.fzf
fi
~/.fzf/install

pushd "${PACKAGE_PATH}"

if [ ! -d molokai ]; then
	git clone https://github.com/tomasr/molokai.git
fi

if [ ! -d nerdcommenter ]; then
	git clone https://github.com/preservim/nerdcommenter.git
fi

if [ ! -d nerdtree ]; then
	git clone https://github.com/preservim/nerdtree.git
fi

if [ ! -d vim-textobj-user ]; then
	git clone https://github.com/kana/vim-textobj-user.git
fi

if [ ! -d vim-textobj-entire ]; then
	git clone https://github.com/kana/vim-textobj-entire.git
fi

if [ ! -d vim-surround ]; then
	git clone https://github.com/tpope/vim-surround.git
fi

if [ ! -d vim-closetag ]; then
	git clone https://github.com/alvan/vim-closetag.git
fi

if [ ! -d vim-go ]; then
	git clone https://github.com/fatih/vim-go
fi

if [ ! -d fzf.vim ]; then
	git clone https://github.com/junegunn/fzf.vim
fi

if [ ! -d vim-projectionist ]; then
	git clone https://github.com/tpope/vim-projectionist.git
fi

if [ ! -d vim-obsession ]; then
	git clone https://github.com/tpope/vim-obsession.git
fi

if [ ! -d ale ]; then
	git clone https://github.com/dense-analysis/ale.git
fi

if [ ! -d editorconfig-vim ]; then
	git clone https://github.com/editorconfig/editorconfig-vim.git
fi

if [ ! -d coc.nvim ]; then
  git clone --branch release https://github.com/neoclide/coc.nvim.git --depth=1
fi

if [ ! -d vim-airline ]; then
  git clone https://github.com/vim-airline/vim-airline.git
fi

### Mac specific

if [ ! -d vim-colors-solarized ]; then
	git clone https://github.com/altercation/vim-colors-solarized.git
fi

popd
