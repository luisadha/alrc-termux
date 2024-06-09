#!/data/data/com.termux/files/usr/bin/bash

# By Luisadha x fmway

PREFIX="/data/data/com.termux/files/usr"
TERMUX_BIN="${PREFIX}/bin"
REPO="https://github.com/luisadha/alrc-termux.git"

ALRC_HOME="$HOME/.local/share/alrc-termux"

_run() {
  echo "run: $@"
  $@
  return $?
}

alrc_install() {
  _run git clone "$REPO" "$ALRC_HOME"
  [ -e "${TERMUX_BIN}/alrc" ] && _run rm -v "${TERMUX_BIN}/alrc"
  _run ln -sv "$ALRC_HOME/alrc" "${TERMUX_BIN}/alrc"

  [ -f $HOME/.shortcuts/alrc.test ] && _run rm -v "$HOME/.shortcuts/alrc.test"
  _run ln -sv "$ALRC_HOME/test/.shortcuts/alrc.test" "$HOME/.shortcuts/alrc.test"
  
  echo
  echo "alrc installed successfully"
  echo "please add $ALRC_HOME/env.sh or alrc environment to your bash config"
  echo -e "\tsource <(\$HOME/.local/bin/alrc env)"
  echo
  source <(alrc env)
}

if ! command -v git &>/dev/null; then
  echo "git not found"
  _run pkg install git
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
