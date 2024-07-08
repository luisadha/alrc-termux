#! bash alrc-termux.module

if [[ -x $(which starship 2>/dev/null) ]]; then
  eval "$(starship init bash)"

plugin_shortname=$(echo "${BASH_SOURCE[0]}" | awk '{gsub(/.*[/]|[.].*/, "", $0)} 1' )
 ps=${plugin_shortname} alrc_plugin_enabled+=($plugin_shortname)

 readarray -t alrc_plugin_enabled <<< $(printf "%s\n" "${alrc_plugin_enabled[@]}" | sort -u)

 echo -e "alrc-termux: Plugin ${ps} successfully loadded!\nplease setup your prompt via .bashrc for example: \`starship preset tokyo-night ~\$ALRC_HOME/prompt/starship/tokyo-night.toml'."

 mkdir -p $ALRC_HOME/prompt/starship/

for import in $(starship preset -l); do
eval "starship preset $import > $ALRC_HOME/prompt/starship/${import}.toml"; 
done

if [ $ALRC_USE_STARSHIP == "random" ]; then
  echo "y"
  al_shuf_starship_prompt
else
  echo "n"
fi


  unset ps;
  unset plugin_shortname;
  unset import

fi
