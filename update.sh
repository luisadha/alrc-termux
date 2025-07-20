#!/data/data/com.termux/files/usr/bin/bash
# By fmway
ALRC_HOME="$(cd -- "$(dirname -- "$(realpath "${BASH_SOURCE[0]}")")" && pwd)"

_run() {
    echo "run: $@"
    $@
    return $?
}

if ! command -v git &>/dev/null; then
    echo "git not found"
    _run pkg install git
fi

pushd $ALRC_HOME &>/dev/null
_run git pull
popd &>/dev/null

# [ -e "$HOME/.local/bin/alrc" ] || _run ln -sv "$ALRC_HOME" "$HOME/.local/bin/alrc"
