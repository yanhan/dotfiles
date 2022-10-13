# funcs.sh: define functions that you want to use from the shell, just
# like how you would use programs on the PATH or builtins

b64d() {
  base64 -d <<< "${1}"; echo
}

new_bash_script() {
  if [ "${#}" -ne 1 ]; then
    printf >&2 "Usage: %s <filename>\n" "${funcstack}"
    return 1
  fi

  if [ -f "${1}" ]; then
    printf >&2 "Error: file/dir '%s' exists. Please run with another filename, or remove the original file and try again.\n" "${1}"
    return 1
  fi

  cat >"${1}" <<EOF
#!/bin/bash

set -euo pipefail
IFS=$'\n\t'

main() {
}

main "\$@"
EOF

  chmod "${1}"
  # Open the script and shift cursor to line 6
  v +6 "${1}"
}

vimman() {
  local rc
  set +e
  command -v nvim >/dev/null 2>&1
  rc="${?}"
  set -e
  if [ "${rc}" -eq 0 ]; then
    MANPAGER="/bin/sh -c \"col -b | nvim -c 'set ft=man ts=8 nomod nolist noma number' -\"" man "$@"
  else
    MANPAGER="/bin/sh -c \"col -b | vim -c 'set ft=man ts=8 nomod nolist noma number' -\"" man "$@"
  fi
}

shorturl() {
  # Cool way to URL encoded on the command line without having to use
  # external libraries.
  # Source: https://stackoverflow.com/a/2027690
  curl \
    -i \
    -G \
    --data-urlencode 'format=simple' \
    --data-urlencode "url=${1}" \
    https://is.gd/create.php
  echo
}

serve_pwd() {
  local optname
  local address=127.0.0.1
  local port=8000
  local opt
  while getopts "p:s:" opt; do
    case "${opt}" in
      p)
        port=${OPTARG}
        ;;
      s)
        address=${OPTARG}
        ;;
      *)
        printf >&2 "%s: unknown option \"%s\"\n" "${funcstack}" "${opt}"
        return 1
        ;;
    esac
  done
  python -m http.server --bind "${address}" "${port}"
}

ssh_rm_host() {
  ssh-keygen -f "${HOME}"/.ssh/known_hosts -R "${1}"
}

# Inspired by an example in https://github.com/junegunn/fzf/wiki/Examples
# fuzzy grep open using rg, with line number
vg() {
  if [ "${#}" -eq 0 ]; then
    printf >&2 "Usage: ${0} searchterm\n"
    printf >&2 "\nUses rg to search for a string in files, use fzf to select which to open\n"
    return 1
  fi
  local file
  local line
  read -r file line <<<"$(rg --no-heading -n $@ | fzf -0 -1 | awk -F: '{print $1, $2}')"
  if [[ -n "${file}" ]]; then
    v "${file}" +"${line}"
  fi
}
