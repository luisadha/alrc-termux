#! bash alrc-termux.module


alias al_login='source $ALRC_HOME/$ALRC_SOURCE; set -o history';

#ping -c 1 -w 5 google.com &>/dev/null || echo -e "${warn}WARN:${reset}: This action requires an active ${italic}internet${reset} connection.\n"

if [ ! -f $ALRC_HOME/cache/box-designs-templete.txt ]; then

echo -e ${info}"INFO${reset}: Sedang mengunduh... add-on untuk fitur custom motd dengan border, dibutuhkan untuk package ${bold}boxes.${reset}"

 curl -fSsl https://boxes.thomasjensen.com/v2.3.0/box-designs.html -o $ALRC_HOME/cache/box-designs-templete.txt 2>/dev/null

if [ $? -eq 0 ]; then
 echo -e ${info}"INFO:${reset}: ... done!${reset}"
else
 echo -en ${error}"ERROR:${reset} Failed."
fi
fi