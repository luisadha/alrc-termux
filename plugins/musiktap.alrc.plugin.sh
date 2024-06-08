#! bash alrc-termux.module
plugin_shortname=$(echo "${BASH_SOURCE[0]}" | awk '{gsub(/.*[/]|[.].*/, "", $0)} 1' )
alrc_plugin_enabled+=($plugin_shortname)
readarray -t alrc_plugin_enabled <<< $(printf "%s\n" "${alrc_plugin_enabled[@]}" | sort -u)

function main() {
local ps="${plugin_shortname}"
cat <<- "EOF" > $HOME/.shortcuts/musiktap.app

# Cli-apps for termux widget "Musiktap adalah konfigurasi untuk menjalankan library musik.sh"
# Load module from alrc-termux
# You should install alrc-termux first!
#by luisadha 
#

export IMG_COVER="$HOME/.local/share/alrc-termux/img/miku_75949.png" # path to your image for ascii generating
#export COLOR_GRADIENT="magma" # uncomment to random generate gradient colors
export ANIMATE_DURATION=5 # Durasi animasi pewarna diset ke nol secara default.
export DATE="static" # static yaitu menampilkan jam dan menit saat terakhir program dijalankan
# Unkomentar untuk generate ke dinamis mengikuti menit saat ini /realtime.
export MAX_COLUMN=296

bash --init-file ~/.local/share/alrc-termux/lib/music.sh
# Tidak pakai source karena pasti bakal error

EOF
}

echo "+1 \"${ps}.app\" files Added at ~/.shortcuts."
main;
unset -f main;
unset plugin_shortname
