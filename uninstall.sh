#!/usr/bin/env bash
# By fmway
ALRC_HOME="$(cd -- "$(dirname -- "$(realpath "${BASH_SOURCE[0]}")")" && pwd)"

_run() {
  echo "run: $@"
  $@
  return $?
}

_run unlink "$HOME/.local/bin/alrc"
_run rm -rf "$ALRC_HOME"
echo "alrc-termux deleted successfully"
echo "please remove environment alrc-termux from your bash config"
