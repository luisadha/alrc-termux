#! bash alrc-termux.module
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
echo "1 files Added at ~/.shortcuts."
return 1
}
alrc_plugin_enabled+=(drawercli)
readarray -t alrc_plugin_enabled <<< $(printf "%s\n" "${alrc_plugin_enabled[@]}" | sort -u)
main() {
  if ! grep -q 'source /data/data/com.termux/files/home/.drawercli_aliases' ~/.bashrc; then cat >> ~/.bashrc <<EOF

# Load drawercli alias
source /data/data/com.termux/files/home/.drawercli_aliases
EOF
if [[ ! -x $(command -v drawercli 2> /dev/null) ]];
  then
   
  if timeout 10s curl -fSsl "https://raw.githubusercontent.com/luisadha/drawercli/main/drawercli.sh" -o ~/.local/bin/drawercli 2> /dev/null && chmod +x ~/.local/bin/drawercli; 
  then
 i_install
  else
   set +e
   echo -n "Failed. Timeout or network issue.";
   return 1
  fi

fi
set +o noclobber
sleep 1
i_setup
if ! grep -q 'source /data/data/com.termux/files/home/storage/shared/termuxlauncher/.apps-launcher' ~/.bashrc; then
cat >> ~/.bashrc <<EOF

# Init termuxlauncher
source /data/data/com.termux/files/home/storage/shared/termuxlauncher/.apps-launcher
EOF
fi

  if [ ! -f ~/.drawercli_aliases ]; then
cat <<- "EOF" > ~/.drawercli_aliases
# Generate by plugin drawercli.alrc.plugin.sh
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
  else
    set +e
     i_found
  fi
  
}
main

unset -f i_install
unset -f i_succ
unset -f i_setup
unset -f i_linkin
unset -f i_found
unset -f main
