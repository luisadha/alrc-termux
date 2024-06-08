#! bash alrc-termux.module
if [[ ! ${bash_preexec_imported:-${__bp_imported:-}} ]]; then
  source "$ALRC_HOME/tools/bash-preexec.sh"

  plugin_shortname=$(echo "${BASH_SOURCE[0]}" | awk '{gsub(/.*[/]|[.].*/, "", $0)} 1' )
 ps=${plugin_shortname} alrc_plugin_enabled+=($plugin_shortname)
  readarray -t alrc_plugin_enabled <<< $(printf "%s\n" "${alrc_plugin_enabled[@]}" | sort -u)
echo -e "alrc-termux: Plugin ${ps} successfully loadded!\n"
echo -e "\tTrying to check precmd & preexec functions if any... ";
if [ "$(type -t precmd)" == "function" ] && [ "$(type -t preexec)" == "function" ]; then
    echo -e "${info}INFO:${reset} Present"
  else
    echo -e "${warn}WARN:${reset} But not configured, For how to use it visit this repository ${underline}<https://github.com/rcaloras/bash-preexec>${reset}"
fi
 
  unset ps
  unset plugin_shortname
fi
