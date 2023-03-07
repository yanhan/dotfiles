#!/bin/bash

readonly PACK_PATH="${HOME}/.local/share/nvim/site/pack"
if [ ! -d "${PACK_PATH}" ]; then
	mkdir -pv "${PACK_PATH}"
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
clone_plugin_repo packer.nvim https://github.com/wbthomason/packer.nvim --depth 1
#install_vim_go
#clone_plugin_repo vim-projectionist https://github.com/tpope/vim-projectionist.git
#clone_plugin_repo vim-obsession https://github.com/tpope/vim-obsession.git
#install_coc_nvim
#install_jedi_vim
#
#### Mac specific
popd
