#! bash alrc-termux.module

if [[ -x $(which starship 2>/dev/null) ]]; then

set +o noclobber
plugin_shortname=$(echo "${BASH_SOURCE[0]}" | awk '{gsub(/.*[/]|[.].*/, "", $0)} 1' )
 ps=${plugin_shortname};
 alrc_plugin_enabled+=($plugin_shortname);

 readarray -t alrc_plugin_enabled <<< $(printf "%s\n" "${alrc_plugin_enabled[@]}" | sort -u)

# temporary commented
# echo -e "alrc-termux: Plugin ${ps} successfully loadded!"

 mkdir -p $ALRC_HOME/prompt/starship/ &>/dev/null

for import in $(starship preset -l); do
eval "starship preset $import > $ALRC_HOME/prompt/starship/${import}.toml"; 
done

if [ $ALRC_USE_STARSHIP == "random" ]; then
  al_shuf_starship_prompt &>/dev/null
fi
  eval "$(starship init bash)"
  unset ps;
  unset plugin_shortname;
  unset import

fi
