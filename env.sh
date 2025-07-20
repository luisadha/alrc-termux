#!/data/data/com.termux/files/usr/bin/bash
# By fmway
[[ $PATH =~ "$HOME/.local/bin" ]] || export PATH="$HOME/.local/bin:$PATH"

cat "$(cd -- "$(dirname -- "$(realpath "${BASH_SOURCE[0]}")")" && pwd)/alrc-termux.sh"
