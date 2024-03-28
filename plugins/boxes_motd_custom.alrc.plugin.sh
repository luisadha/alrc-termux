#! bash alrc-termux.module

if [ ! "$ALRC_MOTD_USE_BOXES" == "random" ]; then
  alias al='setterm --cursor on; al | sort -i | boxes -d $ALRC_MOTD_USE_BOXES; set -o history;'
else
# Beritahu bahwa plugin ini telah diaktifkan dengan array
plugin_shortname=$(echo "${BASH_SOURCE[0]}" | awk '{gsub(/.*[/]|[.].*/, "", $0)} 1' )
alrc_plugin_enabled+=($plugin_shortname)
readarray -t alrc_plugin_enabled <<< $(printf "%s\n" "${alrc_plugin_enabled[@]}" | sort -u)

# Periksa kondisi jika plugin ini aktif maka akan memodifikasi fungsi al ke alias al
if [[ "${alrc_plugin_enabled[@]}" =~ "$plugin_shortname" ]]; then

    alias al='al | sort -i | boxes -d $(al_shuf_boxes_design); set -o history; setterm --cursor on;';
fi
unset plugin_shortname
fi
#ping -c 1 -w 5 google.com &>/dev/null || echo -e "${warn}WARN:${reset}: This action requires an active ${italic}internet${reset} connection.\n"
# Periksa apakah sudah ada file template border jika tidak maka mendownload automatis
if [ ! -f $ALRC_HOME/cache/box-designs-templete.txt ]; then

echo -e ${info}"INFO${reset}: Sedang mengunduh... add-on untuk fitur custom motd dengan border, dibutuhkan untuk package ${bold}boxes.${reset}"

 curl -fSsl https://boxes.thomasjensen.com/v2.3.0/box-designs.html -o $ALRC_HOME/cache/box-designs-templete.txt 2>/dev/null

if [ $? -eq 0 ]; then
 echo -e ${info}"INFO:${reset}: ... done!${reset}"
else
 echo -en ${error}"ERROR:${reset} Failed."
fi
fi
