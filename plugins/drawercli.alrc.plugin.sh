
#set -o errexit
set -e
i_install() {

    echo -n "Installing ..."; echo;
   
}
i_linkin() {
   sleep 1; 
   echo "Linking ..."
 }
i_setup() {
   echo "Setup drawercli ..."
}
i_succ() {
  echo "Successfull, drawercli package has been installed!"
}

i_found() {
#echo "udah ada nih"
return 1
}

main() {
set -e
  if ! grep -q 'alrc_plugin_enabled=(drawercli)' ~/.bashrc; then cat >> ~/.bashrc <<EOF

alrc_plugin_enabled=(drawercli)
EOF
  else
     i_found
  fi
  
}
main

if [[ ! -x $(command -v alfetch 2> /dev/null) ]];
  then
   #i_install
  if timeout 10s curl -fSsl "https://raw.githubusercontent.com/luisadha/drawercli/main/drawercli.sh" -o ~/.local/bin/drawercli 2> /dev/null && chmod +x ~/.local/bin/drawercli; 
  then
 i_install
  else      echo -n "Failed. Timeout or network issue.";
    
  fi
fi
set +o noclobber
sleep 1
i_setup
if ! grep -q 'termuxlauncher_config=true' ~/.bashrc; then
cat >> ~/.bashrc <<EOF

# Init termuxlauncher & drawercli aliases
source $HOME/storage/shared/termuxlauncher/.apps-launcher 2> /dev/null 
source $HOME/.drawercli_aliases
termuxlauncher_config=true
EOF
fi

  if [ ! -f ~/.drawercli_aliases ]; then
cat <<- "EOF" > ~/.drawercli_aliases
# Generate by plugin drawercli.plugin.alrc
# require termuxlauncher app

alias apps='drawercli'
alias app_favorites='drawercli -u'
alias app_recomendations='drawercli -S'
alias app_refesh='drawercli -r'
alias app_wallpaper='drawercli -w'
EOF
fi
set +e
i_linkin
    ln -s ~/.local/bin/drawercli ~/.shortcuts/drawercli 2>/dev/null;
  install ~/.shortcuts/drawercli ~/.shortcuts/drawercli.app 2>/dev/null;
i_succ


