#! bash alrc-termux.module
function collect_applist() {
  echo -e "Collecting..." ; sleep 1 ;

if [[ -f ~/storage/shared/termuxlauncher/.apps-launcher ]] ; then echo -e "Collected\nlist installed apps :" ; echo ;

sed -n '/--list|-l)/,/\;\;/p' /sdcard/termuxlauncher/.apps-launcher | sed '1d;$d' | sed s'/printf//g' | sed s'/\"//g' | sed 's/\\n/ /g' | awk '{print $1}'


else echo "Error: Please install Termuxlauncher.apk's available project termuxlauncher at https://github.com/amsitlab/termuxlauncher/releases" ; fi

}
alrc_plugin_enabled+=(collect_applist)
readarray -t alrc_plugin_enabled <<< $(printf "%s\n" "${alrc_plugin_enabled[@]}" | sort -u)
echo "collect_applist() Added."
