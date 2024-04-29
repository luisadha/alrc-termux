#! bash alrc-termux.module

: " Alhamdulillah fix"
: " Perbaikan pada perilaku fungsi al() yang sebelumnya terdapat bug setterm --linewrap gak mau on "
# Beritahu bahwa plugin ini telah diaktifkan dengan array
plugin_shortname=$(echo "${BASH_SOURCE[0]}" | awk '{gsub(/.*[/]|[.].*/, "", $0)} 1' )
alrc_plugin_enabled+=($plugin_shortname)
readarray -t alrc_plugin_enabled <<< $(printf "%s\n" "${alrc_plugin_enabled[@]}" | sort -u)
    function al_motd() { 
      unalias al; 
      source $ALRC_HOME/alrc-termux.sh;
    }; 
    declare -f -x al_motd

if [ ! "$ALRC_MOTD_USE_BOXES" == "random" ]; then
  
    alias al='al_opt'
    export al='al_motd'

else # random
# Perubahan perilaku pemanggilan al() sebagai default diubah ke $al dan mengembalikan fitur al OPTION lagi yang sebelumnya tidak dapat dikompromi
if [[ "${alrc_plugin_enabled[@]}" =~ "$plugin_shortname" ]]; then
# mungkin dapat digunakan kembali
# al_redirect="al not available when you enable boxes plugin, but you can type \$al instead \`al'"
#al_redirect="Mohon gunakan \$al alih-alih 'al'"
    alias al='al_opt'
    export al='al_motd'
  fi
  
fi
unset -n plugin_shortname
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
