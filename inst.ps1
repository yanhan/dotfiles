Set-Variable -Name PACK_PATH -Option Constant -Value "$env:LOCALAPPDATA\nvim-data\site\pack"
Set-Variable -Name NEWLY_CLONED -Option Constant -Value "NEWLY_CLONED"

function clone-plugin-repo {
  param (
    [string]$PluginName,
    [string]$RepoURL
  )
  $PluginDir = "${PluginName}\start"
  if (-Not (Test-Path -Path $PluginDir)) {
    mkdir $PluginDir
    pushd $PluginDir
    git clone $Args $RepoURL
    popd
    return $NEWLY_CLONED
  }
}

function install-coc-nvim {
  $output = clone-plugin-repo -PluginName coc.nvim -RepoURL https://github.com/neoclide/coc.nvim.git --branch release --depth 1
  if ($output -match "${NEWLY_CLONED}$") {
    pushd "${PACK_PATH}\coc.nvim\start"
    nvim -c 'helptags coc.nvim/doc/ | q'
    popd
  }
}

Set-Variable -Name INIT_VIM_DIR -Option Constant -Value "$env:LOCALAPPDATA\nvim"
Set-Variable -Name INIT_VIM_PATH -Option Constant -Value "${INIT_VIM_DIR}\init.vim"
Set-Variable -Name DOTFILES_VIMRC_PATH -Option Constant -Value "${env:HOMEDRIVE}${env:HOMEPATH}\dotfiles\vimrc"
if (-Not (Test-Path -Path "${INIT_VIM_DIR}")) {
  mkdir ${INIT_VIM_DIR}
}

if (-Not (Test-Path -Path "${INIT_VIM_PATH}")) {
  # Write content without BOM: https://stackoverflow.com/a/5596984
  # Also see https://stackoverflow.com/a/44246434
  $content = "source ${DOTFILES_VIMRC_PATH}"
  $utf8NoBomEncoding = New-Object System.Text.UTF8Encoding $False
  [System.IO.File]::WriteAllLines($INIT_VIM_PATH, $content, $utf8NoBomEncoding)
}

if (-Not (Test-Path -Path "${PACK_PATH}")) {
  mkdir ${PACK_PATH}
}

pushd "$PACK_PATH"
clone-plugin-repo -PluginName molokai -RepoURL https://github.com/tomasr/molokai.git
clone-plugin-repo -PluginName nerdcommenter -RepoURL https://github.com/preservim/nerdcommenter.git
clone-plugin-repo -PluginName nerdtree -RepoURL https://github.com/preservim/nerdtree.git
clone-plugin-repo -PluginName vim-textobj-user -RepoURL https://github.com/kana/vim-textobj-user.git
clone-plugin-repo -PluginName vim-textobj-entire -RepoURL https://github.com/kana/vim-textobj-entire.git
clone-plugin-repo -PluginName vim-surround -RepoURL https://github.com/tpope/vim-surround.git
clone-plugin-repo -PluginName vim-closetag -RepoURL https://github.com/alvan/vim-closetag.git
# From https://github.com/junegunn/fzf.vim/issues/888
clone-plugin-repo -PluginName fzf -RepoURL https://github.com/junegunn/fzf.git
clone-plugin-repo -PluginName fzf.vim -RepoURL https://github.com/junegunn/fzf.vim
clone-plugin-repo -PluginName vim-projectionist -RepoURL https://github.com/tpope/vim-projectionist.git
clone-plugin-repo -PluginName vim-obsession -RepoURL https://github.com/tpope/vim-obsession.git
clone-plugin-repo -PluginName ale -RepoURL https://github.com/dense-analysis/ale.git
clone-plugin-repo -PluginName editorconfig-vim https://github.com/editorconfig/editorconfig-vim.git
clone-plugin-repo -PluginName vim-airline -RepoURL https://github.com/vim-airline/vim-airline.git
# TODO: color is not rendered correctly...
clone-plugin-repo -PluginName vim-airline-themes -RepoURL https://github.com/vim-airline/vim-airline-themes.git
install-coc-nvim
popd
