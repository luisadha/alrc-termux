
# ! bash alrc-termux.module
# Version 1.5 beta music.sh
# By Luis Adha
# COMMENTS ONLY AVAILABLE IN BAHASA (INDONESIAN LANGUAGE)

# IMPORT 
#source ${ALRC_HOME}/lib/ext_command_helper.sh
#source <(~/.local/bin/alrc env)> /dev/null 2>&1; 
#     \ ini akan mengimpor fungsi
#      \ brandomusic(),
#       \ al_notify() dan
#        \ lolcrab_gradient_shuf

# SETUP CONFIG IN ~/.SHORTCUTS/MUSIKTAP.APP
##! MOHON JANGAN UNKOMENTAR BAGIAN INI, INI SEKEDAR ARAHAN  UNTUK KONFIGURASI
# Setting di konfigurasi
#export IMG_COVER=() Jalur file gambar. cth.: ~/download/hatsune_miku.jpg
#export MAX_COLUMN=() Lebar maksimal huruf terminal anda, nilai semula 141 cocok untuk Redmi 10C.
#export ANIMATE_DURATION=() Durasi animasi warna masukan nilai integer, nilai semula adalah 0.
#export COLOR_GRADIENT=() # Masukan Warna Gradien anda lihat di `lolcrab --help'. jika tidak diberi nilai maka automatis nilai random diberikan.

# VARIABLE
export PATH="$PATH:~/.cargo/bin"
#mediaPlayerProccess=$(termux-media-player info)
# getRandom=$(al_shuf_lolcrab_gradient)

# CHECK DEPENDENCIES
: "check_dependency lolcrab
check_dependency coreutils
check_dependency termux-media-player
check_dependency brandomusicx
check_dependency jp2a
check_dependency python3 "
pip show halo &>/dev/null || echo "Python (halo) module not installed!"


# Check environment
if [ -z "$MAX_COLUMN" ]; then
  MAX_COLUMN=141
fi
if [ "$DATE" == "static" ]; then
 _DATE=$(echo "$(date '+%A, %B %d, %Y at %H:%M')")
static_date=true
fi

function brandomusicx {
   # Created by @luisadha
  
   help() {
(
echo -e "BrandomusicXtended (brandomusicx) is an shortcut for function brandomusic.\n" >&2;

echo -e "Powered by TERMUX API\n
Available options : " >&2;

  echo -e " [\"help\", \"kill\", \"pause\", \"resume\", \"shuffle\" ]"; 
  )
}

opti="$1"
if [ -z "$opti" ]; then
  help;

elif [ "$opti" == "shuffle" ] || [ "$opti" == "play" ]; then
cd ~
set +o noclobber
termux-media-player play "$(realpath "$(busybox ls ~/**/*.mp3 | shuf -n1)" )" > ${ALRC_HOME:-~/.alrc.sandbox}/cache/title-songs.txt;
cd - &>/dev/null;
elif [ "$opti" == "help" ]; then
  help;
elif [ "$opti" == "resume" ]; then
termux-media-player play;
printf "Play songs with Type \`${FUNCNAME[0]}'.\n"
elif [ "$opti" == "pause" ]; then
termux-media-player pause;
elif [ "$opti" == "kill" ]; then
termux-media-player stop;
 else
echo "see: \`${FUNCNAME[0]} help' more details."
fi
unset -f help
}
declare -f -x brandomusicx
# Fungsi-fungsi
function __main__()
{
          brandomusicx shuffle #> /dev/null 2>&1;
}
renderImageView() {
local arg="$1"
jp2a --term-width "$arg"
}
drawTextFill() {
 local arg=$1;
 local cols=$(tput cols)
 local calc=$(echo "${cols} - ${#arg}" | bc)
 echo -n $arg && printf %"$calc"s | tr " " "-"
}
loadingAnimation() {
    bash ${ALRC_HOME:-~/.alrc.sandbox}/lib/progsche.sh -c '$' 08 "$(songTitle)"
# python3 ${ALRC_HOME:-~/.alrc.sandbox}/lib/fetchSongTitle_animation.py
}
songTitle() {
termux-media-player info | xargs -n1 | grep -v "Status:" | grep -v "Track:" | grep -v "Current" | grep -v "Position:" | xargs -d "\n" | awk '{print $1,$2}'
}
fetchSongInfo() {
termux-media-player info | xargs -n1 | grep -v "Status:" | grep -v "Track:" | grep -v "Current" | grep -v "Position:" | xargs -d "\n"
}
bannerAnimation() {
if [ "$static_date" == "true" ]; then
#echo ya
drawTextFill "$_DATE" | fold -w$COLUMNS
else
drawTextFill "$(date '+%A, %B %d, %Y at %H:%M')" | fold -w$COLUMNS
fi

echo "$(fetchSongInfo | fold -w$COLUMNS)" | lolcrab -a --duration ${ANIMATE_DURATION:-0} -g ${COLOR_GRADIENT:-$getRandom}
sleep 0.1
}

case $- in
  *i*) __main__; ;;
    *) echo "this option request interactive shell mode" 1>&2; exit;;
esac

#          set -xv
if [ ! "$COLUMNS" == "$MAX_COLUMN" ]; then
termux-toast "Your column is $(tput cols), Pinch zoom out to $MAX_COLUMN column to see extended animation. But you can skip this warning ";  read REPLY
fi;
      echo
      loadingAnimation;
      echo ''
      echo; 
( 
cols=$(tput cols);
while true; do
  if [ "$(termux-media-player info)" == "No track currently!" ]; then
    exit 1
  fi
  if [ "$cols" == "$MAX_COLUMN" ]; then    
renderImageView "$IMG_COVER"
bannerAnimation
#read REPLY
   continue
  fi
done ) &

# 963277
