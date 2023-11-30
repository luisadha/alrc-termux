cat <<- "EOF" > $HOME/.drawercli_aliases
# Generate by plugin drawercli.plugin.alrc
# require termuxlauncher app

alias apps='drawercli'
alias app_favorites='drawercli -u'
alias app_recomendations='drawercli -S'
alias app_refesh='drawercli -r'
alias app_wallpaper='drawercli -w'
EOF



main() {
 local present=
if type drawercli &> /dev/null; then
  present=true
  source ~/.drawercli_aliases
else present=false;
  echo "Are you sure to download the package?"
 


 fi
}
main
unset -f main
