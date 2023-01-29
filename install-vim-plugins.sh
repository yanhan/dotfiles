#!/bin/bash

readonly PACK_PATH="${HOME}/.local/share/nvim/site/pack"
readonly PACKAGE_PATH="${PACK_PATH}/bundle/start"
if [ ! -d "${PACKAGE_PATH}" ]; then
	mkdir -pv "${PACKAGE_PATH}"
fi

if [ ! -d ~/.fzf ]; then
  git clone https://github.com/junegunn/fzf.git ~/.fzf
  ~/.fzf/install
fi

readonly NEWLY_CLONED='NEWLY CLONED'

clone_plugin_repo() {
  declare -r plugin_name=${1}
  shift
  declare -r repo_url=${1}
  shift
  declare -r plugin_dir="${plugin_name}/start"
  if [ ! -d "${plugin_dir}" ]; then
    mkdir -pv "${plugin_dir}"
    pushd "${plugin_dir}"
    set -x
    git clone "$@" "${repo_url}"
    set +x
    popd
    echo "${NEWLY_CLONED}"
  fi
}

install_vim_go() {
  local output
  output="$(clone_plugin_repo vim-go https://github.com/fatih/vim-go.git)"
  output="$(tail -1 <<< "${output}")"
  if [ "${output}" = "${NEWLY_CLONED}" ]; then
    nvim -c 'GoInstallBinaries' -c q
  fi
}

install_coc_nvim() {
  local output
  output="$(clone_plugin_repo coc.nvim https://github.com/neoclide/coc.nvim.git --branch release --depth 1)"
  output=$(tail -1 <<< "${output}")
  if [ "${output}" = "${NEWLY_CLONED}" ]; then
    pushd "${PACK_PATH}/coc.nvim/start"
    nvim -c 'helptags coc.nvim/doc/ | q'
    popd
  fi
}

install_jedi_vim() {
  local output
  output="$(clone_plugin_repo jedi-vim https://github.com/davidhalter/jedi-vim.git)"
  output="$(tail -1 <<< "${output}")"
  if [ "${output}" = "${NEWLY_CLONED}" ]; then
    pushd "${PACK_PATH}/jedi-vim/start/jedi-vim"
    git submodule update --init --recursive
    nvim -c 'CocInstall coc-jedi' -c q
    popd
  fi
}

pushd "${PACK_PATH}"
clone_plugin_repo molokai https://github.com/tomasr/molokai.git
clone_plugin_repo nerdcommenter https://github.com/preservim/nerdcommenter.git
clone_plugin_repo nerdtree https://github.com/preservim/nerdtree.git
clone_plugin_repo vim-textobj-user https://github.com/kana/vim-textobj-user.git
clone_plugin_repo vim-textobj-entire https://github.com/kana/vim-textobj-entire.git
clone_plugin_repo vim-surround https://github.com/tpope/vim-surround.git
clone_plugin_repo vim-closetag https://github.com/alvan/vim-closetag.git
install_vim_go
clone_plugin_repo fzf.vim https://github.com/junegunn/fzf.vim
clone_plugin_repo vim-projectionist https://github.com/tpope/vim-projectionist.git
clone_plugin_repo vim-obsession https://github.com/tpope/vim-obsession.git
clone_plugin_repo ale https://github.com/dense-analysis/ale.git
clone_plugin_repo editorconfig-vim https://github.com/editorconfig/editorconfig-vim.git
clone_plugin_repo vim-airline https://github.com/vim-airline/vim-airline.git
install_coc_nvim
install_jedi_vim
clone_plugin_repo darcula https://github.com/doums/darcula
clone_plugin_repo vim-airline-themes https://github.com/vim-airline/vim-airline-themes

### Mac specific
clone_plugin_repo vim-colors-solarized https://github.com/altercation/vim-colors-solarized.git
clone_plugin_repo vim-solarized8 https://github.com/lifepillar/vim-solarized8.git
popd
