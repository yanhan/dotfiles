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
