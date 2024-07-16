if [[ "$HOME/.local/share/blesh/ble.sh" ]]; then
source ~/.local/share/blesh/ble.sh
plugin_shortname=$(echo "${BASH_SOURCE[0]}" | awk '{gsub(/.*[/]|[.].*/, "", $0)} 1' );
ps=${plugin_shortname} alrc_plugin_enabled+=($plugin_shortname);
readarray -t alrc_plugin_enabled <<< $(printf "%s\n" "${alrc_plugin_enabled[@]}" | sort -u)
echo -e "alrc-termux: Plugin ${ps} successfully loadded!\n" 
unset ps; unset plugin_shortname;
fi
