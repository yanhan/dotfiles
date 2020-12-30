#!/bin/bash

set -euo pipefail
IFS=$'\n\t'

main() {
	if [ "$(uname)" != "Darwin" ]; then
		printf "Please use the provision-ubuntu-ansible repo to install neovim-remote\n"
		printf "Exiting.\n"
		exit 1
	fi
	set +u
	eval "$(pyenv init -)"
	set -u

	declare -r python_version=3.9.1
	declare -r pyenv_dir="${HOME}"/.pyenv
	local lines_found

	set +e
	lines_found="$(pyenv versions | grep "${python_version}" | wc -l)"
	set -e
	if [ "${lines_found}" -eq 0 ]; then
		if [ -d "${pyenv_dir}"/.git ]; then
			pushd "${pyenv_dir}"
			git fetch origin
			git merge --ff-only origin/master
			popd
		fi
		pyenv install "${python_version}"
		pyenv global "${python_version}"
		popd
	fi

	set +e
	lines_found="$(pip3 list 2>/dev/null | grep neovim-remote | wc -l)"
	set -e
	if [ "${lines_found}" -eq 0 ]; then
		pip3 install --user neovim-remote
	fi
}

main
