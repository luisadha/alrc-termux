#!/data/data/com.termux/files/usr/bin/bash
# By fmway

REPO="https://codeberg.org/luisadha/alrc-termux.git"

ALRC_HOME="$HOME/.local/share/alrc-termux"

_run() {
  echo "run: $@"
  $@
  return $?
}

alrc_install() {
  _run git clone "$REPO" "$ALRC_HOME"
  [ -e "$HOME/.local/bin/alrc" ] && _run rm -v "$HOME/.local/bin/alrc"
  _run ln -sv "$ALRC_HOME/alrc" "$HOME/.local/bin/alrc"
  echo
  echo "alrc installed successfully"
  #echo "please add $ALRC_HOME/env.sh or alrc environment to your bash config"
  #echo -e "\tsource <(\$HOME/.local/bin/alrc env)"
  sleep 1
  echo "initializing env..."
  sleep 1
    bash ~/.shortcuts/alrc.test 
  echo
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
