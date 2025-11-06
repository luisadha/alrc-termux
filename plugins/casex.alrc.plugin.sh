#! bash alrc-termux.module
if [ $(which casex) ]; then
  ## Configurations
#Comment this line if you want a dynamic prompt. (Komentari baris ini jika Anda ingin tampilan prompt dinamis)
trap '' WINCH
# This make prompt statically (Ini akan membuat prompt menjadi statis)
# Hook prompt
eval "$(casex init bash)"
  plugin_shortname=$(echo "${BASH_SOURCE[0]}" | awk '{gsub(/.*[/]|[.].*/, "", $0)} 1' )
 ps=${plugin_shortname} alrc_plugin_enabled+=($plugin_shortname)
  readarray -t alrc_plugin_enabled <<< $(printf "%s\n" "${alrc_plugin_enabled[@]}" | sort -u)
echo -e "alrc-termux: Plugin ${ps} successfully loadded!" 
  unset ps
  unset plugin_shortname
fi
