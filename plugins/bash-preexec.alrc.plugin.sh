#! bash alrc-termux.module
if [[ ! ${bash_preexec_imported:-${__bp_imported:-}} ]]; then
  source "$ALRC_HOME/tools/bash-preexec.sh"

  plugin_shortname=$(echo "${BASH_SOURCE[0]}" | awk '{gsub(/.*[/]|[.].*/, "", $0)} 1' )
 ps=${plugin_shortname} alrc_plugin_enabled+=($plugin_shortname)
  readarray -t alrc_plugin_enabled <<< $(printf "%s\n" "${alrc_plugin_enabled[@]}" | sort -u)
echo -e "alrc-termux: Plugin ${ps} successfully activated!\n"
echo -e "Trying to check precmd & preexec contents if any... ";
type precmd | head -n 1
type preexec | head -n 1
if [ $? -eq 1 ]; then
 echo -e "For how to use it visit this repository https://github.com/rcaloras/bash-preexec"
fi
 
  unset ps
  unset plugin_shortname
fi
