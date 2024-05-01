
#! bash alrc-termux.module
set +o noclobber
plugin_shortname=$(echo "${BASH_SOURCE[0]}" | awk '{gsub(/.*[/]|[.].*/, "", $0)} 1' )
alrc_plugin_enabled+=($plugin_shortname)
readarray -t alrc_plugin_enabled <<< $(printf "%s\n" "${alrc_plugin_enabled[@]}" | sort -u)
unset plugin_shortname

main() {
  if ! grep -q 'source /data/data/com.termux/files/home/.drawercli_aliases' ~/.bashrc; then

cat >> ~/.bashrc <<EOF

        # Load drawercli alias generated by drawercli plugin alrc
        source /data/data/com.termux/files/home/.drawercli_aliases
EOF
  fi
  if ! grep -q 'source /data/data/com.termux/files/home/storage/shared/termuxlauncher/.apps-launcher' ~/.bashrc; then

cat >> ~/.bashrc <<EOF

# Init termuxlauncher generated by drawercli plugin alrc
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
    ln -s $(type -p drawercli) ~/.shortcuts/drawercli
    install ~/.shortcuts/drawercli ~/.shortcuts/drawercli.app 2>/dev/null;
    echo -e "1 files Added at ~/.shortcuts." 
}
if $(type -p drawercli); then
main
else
    echo '[alrc-termux] drawercli not found, please install it from https://github.com/luisadha/drawercli '
fi
    unset -f main
