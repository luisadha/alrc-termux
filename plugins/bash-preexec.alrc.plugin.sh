if [[ ! ${bash_preexec_imported:-${__bp_imported:-}} ]]; then
  source "$ALRC_HOME/tools/bash-preexec.sh"

  plugin_shortname=$(echo "${BASH_SOURCE[0]}" | awk '{gsub(/.*[/]|[.].*/, "", $0)} 1' )
 ps=${plugin_shortname} alrc_plugin_enabled+=($plugin_shortname)
  readarray -t alrc_plugin_enabled <<< $(printf "%s\n" "${alrc_plugin_enabled[@]}" | sort -u)
echo -e "alrc-termux: plugin ${ps} enabled\n"
echo -e "please edit your precmd or preexec at $ALRC_HOME/lib/ext_command_helper.sh"
  unset ps
  unset plugin_shortname
fi
