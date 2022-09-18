# funcs.sh: define functions that you want to use from the shell, just
# like how you would use programs on the PATH or builtins

b64d() {
  base64 -d <<< "${1}"; echo
}
