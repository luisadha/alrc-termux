#!/data/data/com.termux/files/usr/bin/bash

# By Luisadha x fmway

PREFIX="${PREFIX:-}"
TERMUX_BIN="${PREFIX}/bin"
REPO="https://github.com/luisadha/alrc-termux.git"
BRANCH="v4.3.4"

ALRC_HOME="$HOME/.local/share/alrc-termux"

_run() {
  echo "run: $@"
  $@
  return $?
}

alrc_install() {
  _run git clone -b main "$REPO" "$ALRC_HOME"
  [ -e "${TERMUX_BIN}/alrc" ] && _run rm -v "${TERMUX_BIN}/alrc"
  _run ln -sv "$ALRC_HOME/alrc" "${TERMUX_BIN}/alrc"

  [ -f $HOME/.shortcuts/alrc.test ] && _run rm -v "$HOME/.shortcuts/alrc.test"
  _run ln -sv "$ALRC_HOME/test/.shortcuts/alrc.test" "$HOME/.shortcuts/alrc.test"
  
  echo
  echo "status: alrc installed successfully"
  echo "please add environment to your bash config: "
  echo -e " source <(alrc env)"
  echo
  source <(alrc env)
}

if ! command -v git &>/dev/null; then
  echo "git not found"
  _run pkg install git
fi
  if ! command -v hide_soft_keyboard &>/dev/null; then
  echo -e "'hide_soft_keyboard' not found"
  _run git clone https://github.com/luisadha/hide_soft_keyboard.git
  cd hide_soft_keyboard;
  make install;
  cd - &>/dev/null;
  fi
if [ -d "$ALRC_HOME" ]; then
  echo "alrc-termux already installed"
  echo "updating alrc..."
  if [ -d "$ALRC_HOME/.git" ] && [ -e "$ALRC_HOME/update.sh" ]; then
    _run "$ALRC_HOME/update.sh"
  else
    pushd "$ALRC_HOME" &>/dev/null
    if [ -d ".git" ] && _run git pull; then
      popd &>/dev/null
      _run "$ALRC_HOME/update.sh"
    else
      popd &>/dev/null
      echo "cannot pull the request. back up to the old"
      _run mv -v "$ALRC_HOME" "${ALRC_HOME}_bak_$(date +%s)"
      alrc_install
    fi
  fi
else
  alrc_install
fi
