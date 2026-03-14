#!/usr/bin/bash
# Alfetch - a CLI Bash script to show system information on Android devices in termux 
# Version : v0.0.5b
# Created : 9 November 2023
# Copyright (c) 2023 Luis Adha
#set -xv
version="v0.0.9"
ALFETCH_CONF_VCODE='009'
# 0.0.5b
# ~ Fix bug minor
# ~ Replace tr to sed

reset="\033[0m"
gray="\033[1;90m"
red="\033[1;31m"
green="\033[1;32m"
yellow="\033[1;33m"
blue="\033[1;34m"
magenta="\033[1;35m"
cyan="\033[1;36m"
white="\033[1;37m"
cl0="${gray}"
cl1="${red}"
cl2="${green}"
cl3="${yellow}"
cl4="${blue}"
cl5="${magenta}"
cl6="${cyan}"
cl7="${white}"
clv9="${reset}"
num="2"
_s1_char='┌'
_p2_char='┘'
_s2_char='└'
_p1_char='┐'
border='|'
_draw_char='─' #━' # ─ # - # =
_amazing_char_def="${cl0}  ${cl1} ${cl2} ${cl3} ${cl4} ${cl5} ${reset}"
_amazing_char=${_amazing_char:-$_amazing_char_def}
_len_char=$(echo "$_char" | wc -L)
_cur_cols=$(tput cols) # $(stty size | cut -d" " -f2)
_min_cols=$(echo "$(tput cols) - $_len_char" | bc)
_len_amazing_char=$(echo -e "$_amazing_char" | wc -w)
_final_amazing_char=$(echo -e "$_len_amazing_char * 2" | bc)
_calc=$(echo -e "$_min_cols - $_final_amazing_char" | bc)
_fill_blank=$(printf %"$_calc"s | sed "s/ /$_draw_char/g")




# Cache dir
CACHE_DIR="$HOME/.config/alfetch/cache"
mkdir -p "$CACHE_DIR"

# ------------------- FUNCTIONS -------------------

_os() { uname -so; }
_arch() { uname -m || dpkg --print-architecture; }
_term() { echo "$TERM"; }
_date() { date; }
_kernel() { uname -r; }
_shell() {
  if [ "$(basename "$SHELL")" = "bash" ]; then
    bash --version | head -n1 | awk '{print $1 " " $2 " " $4}'
  elif [ "$(basename "$SHELL")" = "zsh" ]; then
    echo "zsh $ZSH_VERSION"
  else
    echo "unknown"
  fi
}
_packages() {
  local prefix="$PREFIX/bin" sysroot="$SYSROOT/bin"
  ls ${prefix} 2>/dev/null | wc -l || ls ${sysroot} 2>/dev/null | wc -l
}
_uptimes() { uptime --pretty; }

_battery() {
  termux-battery-status | jq -r '"\(.percentage)% \(.status | gsub("_"; " ") | ascii_downcase)"'
}

_song() {
  local info=$(termux-media-player info 2>/dev/null)
  if [[ $info == *"Playing"* ]]; then
    echo "$info" | awk '!/Playing|Position:/ {for(i=2;i<=NF;i++) printf $i " "; print ""}'
  elif [[ $info == *"Paused"* ]]; then
    echo "$info" | awk '!/Position:/ {for(i=2;i<=NF;i++) printf $i " "; print ""}' | sed 's/Paused/ (Dijeda)/'
  else
    echo "No song"
  fi
}

# ------------------- CACHE FUNCTION -------------------

cached() {
  local key=$1
  local func=$2
  local file="$CACHE_DIR/$key.txt"
  # cache 60 sec
  if [[ -f $file && $(find "$file" -mmin -1) ]]; then
    cat "$file"
  else
    $func | tee "$file"
  fi
}

# ------------------- PARALLEL EXECUTION -------------------

export -f _os _arch _term _date _kernel _shell _packages _uptimes _battery _song cached

# Run all tasks in background and wait
(
  cached os _os > $PREFIX/tmp/_os.txt &
  cached arch _arch > $PREFIX/tmp/_arch.txt &
  cached term _term > $PREFIX/tmp/_term.txt &
  cached date _date > $PREFIX/tmp/_date.txt &
  cached kernel _kernel > $PREFIX/tmp/_kernel.txt &
  cached shell _shell > $PREFIX/tmp/_shell.txt &
  cached packages _packages > $PREFIX/tmp/_packages.txt &
  cached uptimes _uptimes > $PREFIX/tmp/_uptimes.txt &
  cached battery _battery > $PREFIX/tmp/_battery.txt &
  cached song _song > $PREFIX/tmp/_song.txt &
  wait
)

# Read results
get_os=$(< $PREFIX/tmp/_os.txt)
get_arch=$(< $PREFIX/tmp/_arch.txt)
get_term=$(< $PREFIX/tmp/_term.txt)
get_date=$(< $PREFIX/tmp/_date.txt)
get_kernel=$(< $PREFIX/tmp/_kernel.txt)
get_shell=$(< $PREFIX/tmp/_shell.txt)
get_packages=$(< $PREFIX/tmp/_packages.txt)
get_uptime=$(< $PREFIX/tmp/_uptimes.txt)
get_battery=$(< $PREFIX/tmp/_battery.txt)
get_song=$(< $PREFIX/tmp/_song.txt)

rm $PREFIX/tmp/_*.txt

# ---------





function fetch() {
  local autoline_wrap=$(echo "${_cur_cols} + 2" | bc)
  local opt="$1" val="$2" border="$3"
  printf %"$_min_cols"s && echo -e "$border\r${opt}" "${val}" | cut -c1-$autoline_wrap
}
function header() {             
  local pre_char="$1" suf_char="$2" add_char="$3"
  printf %"${_min_cols}"s | sed "s/ /${add_char}/g" && echo -e "${pre_char}\r${suf_char}" 
  
 }

function footer() {
  local pre_char="$1" suf_char="$2" add_char="$3"
  printf %"${_min_cols}"s | sed "s/ /${add_char}/g" && echo -e "${pre_char}\r${suf_char}"$_fill_blank"${_amazing_char}"
}

function use_color() {
  local arg1="$*";
  lolcrab -c "$arg1"
}

function move_space() {   
  local arg1=$1;                                             
  printf '%*s%s\n' ${arg1:-0} " "                             
}

function default_header() {

  printf %"$COLUMNS"s | tr " " "-"
}


function main() {
default_header
default_header
fetch ${border}" "" ""▢ border >>"" $(get_border)" "${border}"
fetch ${border}" "" "" os >>" "${get_os} (${get_arch})" "${border}"
fetch ${border}" "" "" term >>" "${get_term}" "${border}"
fetch ${border}" "" "" date >>" "${get_date}" "${border}"
fetch ${border}" "" "" song >>" "${get_song}" "${border}"
fetch ${border}" "" "" kernel >>" "${get_kernel}" "${border}"
fetch ${border}" "" "" shell >>" "${get_shell}" "${border}"
fetch ${border}" "" "" battery >>" "${get_battery}" "${border}"
fetch ${border}" "" "" uptime >>" "${get_uptime}" "${border}"
fetch ${border}" "" "" packages >>" "${get_packages}" "${border}"
default_header
}

[ ! -d ~/.config/alfetch ] && mkdir -p ~/.config/alfetch #&& echo berhasi  lbuat

if [ -f ~/.config/alfetch/alfetch.config.conf ]; then #echo found

conf_value=$(awk -F"'" '/ALFETCH_CONF_VCODE/{print $2}' ~/.config/alfetch/alfetch.config.conf)
    if [ "$conf_value" == "$ALFETCH_CONF_VCODE" ]; then
      source ~/.config/alfetch/alfetch.config.conf 
   else
      echo "Wrong config!"; #main
   fi
else
     main
fi
