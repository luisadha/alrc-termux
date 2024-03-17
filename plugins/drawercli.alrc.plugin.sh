
: "function _create_config() {
  cat <<- "EOF" > $HOME/.drawercli_aliases
# Generate by plugin drawercli.plugin.alrc
# require termuxlauncher app

alias apps='drawercli'
alias app_favorites='drawercli -u'
alias app_recomendations='drawercli -S'
alias app_refesh='drawercli -r'
alias app_wallpaper='drawercli -w'
EOF
}

function download_drawercli() {
if [ ! -x $(command -v drawercli 2>/dev/null) ]; then
  
   echo -en "Downloading.. ";

    if timeout 10s curl -fSsl "https://raw.githubusercontent.com/luisadha/drawercli/main/drawercli" -o ~/.local/bin/drawercli 2> /dev/null && chmod +x ~/.local/bin/drawercli; 
    then sleep 1; echo -e " Done!"; onCreate;
    else echo -e "Failed. Timeout or network issue."; return 1;
    fi
fi


}

  function ask() {

  echo -e "${1} ${2}? [Y/n] " 
  read SWITCH_CASE

  case "$SWITCH_CASE" in

    "" )
      ${3}
    ;;

    y|Y )
      ${3}
    ;;

    n|N )
      echo "Abort."
      return 1
    ;;

    * )
      echo " Unknown '${SWITCH_CASE}'"
      ask ${1} ${2} ${3}
    ;;

  esac

}


function onCreate() {
 if [ -f ~/.drawercli_aliases ]; then
  source ~/.drawercli_aliases
else
  echo -en "Creating config files.. "
_create_config
source ~/.drawercli_aliases
echo " Done!"; sleep 1; echo "You can find the configuration file at ~/.drawercli_aliases"
 fi

}

main() {
 local present=
if type drawercli &> /dev/null; then
  present=true
  onCreate
else 
present=false;
  ask "Are you sure to download" "the drawercli package?" download_drawercli 
 fi
}
echo "drawercli added"
type drawercli
main
unset -f main
unset -f ask
unset -f onCreate
unset -f download_drawercli
unset -f _create_config 
"
echo "Under maintenance!"

