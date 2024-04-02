#! bash alrc-termux.module
# Alfetch - a CLI Bash script to show system information on Android devices in termux 
# Version : v1.0.0
# Created : 26 Maret 2024
# Copyright (c) 2023 Luis Adha
#set -xv

# 0.0.5b
# ~ Fix bug minor
# ~ Replace tr to sed
# 1.0.0
# ~ Integrate with plugin alrc-termux
# ~ Compatible with pipe to another program, like boxes
# 1.0.1
# - remove tr in default_header
# - fix bug in default_header

unalias fetch &>/dev/null;
#unalias battery &>/dev/null;
version="v1.0.0"
ALFETCH_CONF_VCODE='100'
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
cl9="${reset}"
num="2"

upper_left_corner='┌'; bottom_left_corner='└';
upper_right_corner_='┐'; bottom_right_corner='┘';
border='|'; h_line='─' #━' # ─ # - # =
pretty_bar_const="${cl0}  ${cl1} ${cl2} ${cl3} ${cl4} ${cl5} ${reset}"
pretty_bar_custom=${pretty_bar_custom:-$pretty_bar_const}
_len_char=$(echo "$border" | wc -L)
_cur_cols=$(tput cols) # $(stty size | cut -d" " -f2)
_min_cols=$(echo "$(tput cols) - $_len_char" | bc)
_len_pretty_bar_custom=$(echo -e "$pretty_bar_custom" | wc -w)
_final_pretty_bar_custom=$(echo -e "$_len_pretty_bar_custom * 2" | bc)
_calc=$(echo -e "$_min_cols - $_final_pretty_bar_custom" | bc)
_fill_blank=$(printf %"$_calc"s | sed "s/ /$h_line/g")


# example usage
#printf %"$_min_cols"s && echo "$_char"
#printf %"$_min_cols"s && echo -e "$_char\rHELLO WORD"
#printf %"$_min_cols"s && echo -e "$_char\r${_char} HELLO WORD"

get_border() {
local FETCH_BORDER=${ALRC_MOTD_USE_BOXES:-$(echo "border by alfetch")}
local GET_BORDER=$(al_info_boxes_border 2>/dev/null)
echo "${GET_BORDER:-$FETCH_BORDER}"
}

: "
get_user() {
echo -n "$USER"
}
get_init() {

}
get_gpu() {

} "
get_cpu() {
  CPUINFO="$(cat /proc/cpuinfo | grep 'Hardware' | awk '{print $3,$6}')"
  echo -n "$CPUINFO"
}
: "
get_storage() {

} "
get_dpkgs() {
  echo -n "$(dpkg --get-selections | wc -l) (dpkg)"
}

get_ram() {
echo -n "$(free -m | awk '/Mem/{print $3"MiB / "$2}')MiB"
}
: "
get_model() {

} 
get_android_version() {

}
get_sdk() {

} 

get_baseband() {
}

get_abi() {
}"

ismytermux() {
if [ -d ~/.config/mytermux ]; then \ls -d ~/.config/mytermux | grep -o "mytermux"
else
 echo "mytermux not installed yet!"; 
fi
}
mytermux_font() {
 \cat ~/.config/mytermux/fonts/used.log | sed "s/\.ttf//g"; }
mytermux_colorscheme() {
  \cat ~/.config/mytermux/colorscheme/used.log | sed "s/\.colors//g"; }

get_song() {
isPlaying() {

 termux-media-player info | awk '{print $2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13,$14,$15}' | grep -v "Position:" | xargs
 }
isPlayingEdit() {
termux-media-player info | awk '{print $2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13,$14,$15}' | grep -v "Playing" | grep -v "Position:" | xargs
}

if [ $(isPlaying | awk '{print $1}') == "Playing" ]; then        echo "$(isPlayingEdit)"
elif [ $(isPlaying | awk '{print $1}') == "Paused" ]; then       echo "$(isPlaying)" |  awk '{gsub("Paused", ""); print $0 " (Dijeda)"}'
else                                                             echo "No $(isPlaying)"
fi; 
}
get_os() {
  echo -n "$(uname -so)"; }
get_term() {
  echo -n "$TERM"; }
get_arch() {
 uname -m || dpkg --print-architecture; }
get_date() {
  command date; 
}
get_battery() {
 local batt="$(termux-battery-status 2>&1 | grep -cq 'command not found' || termux-battery-status | head -n 3 | awk '{print $2}' | tail -n 1 | sed 's/,/%/g')";
    local batteries="${batt:-$(echo "unknown")}" > /dev/null 2>&1;
    echo -n "$batteries"; 
}
battery_state() {
if [ $(termux-battery-status | grep "status" | cut -d":" -f2 | tr "[:upper:]" "[:lower:]" | sed "s/\,//g" | sed "s/\"//g" | xargs | sed "s/^/D/g" | cut -c 1,3-12) == "Discharging" ]; then
echo "Discharging"
else
echo "Charging"
fi; 
}
get_uptime() {
 uptime --pretty; 
}
get_packages() {
 local prefix="$PREFIX/bin" 2> /dev/null;
 local sysroot="$SYSROOT/bin" 2> /dev/null;
 local packages_termux="$(command ls ${prefix} 2> /dev/null | wc -l || command ls ${sysroot} 2> /dev/null | wc -l) (usr/bin) " &> /dev/null;
 echo -n "$packages_termux";
 }
get_shell() {
if [ "$(basename "$SHELL")" = "bash" ]; then
  bash_version=$(bash --version | grep 'bash' | head -n1 | awk '{print $4}' | sed 's/\(.*\)(1)-release.*/\1/')
  echo -n "bash $bash_version";
elif [ "$(basename "$SHELL")" = "zsh" ]; then
  echo "zsh $ZSH_VERSION";
else
  echo "unknown";
fi;
 }

get_kernel() {
  uname -r; 
}



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
  printf %"${_min_cols}"s | sed "s/ /${add_char}/g" && echo -e "${pre_char}\r${suf_char}"$_fill_blank"${pretty_bar_custom}"
}

function use_color() {
  local arg1="$*";
  lolcrab -c "$arg1"
}

function padding() {   
  local arg1=$1;                                             
  printf '%*s%s' ${arg1:-0} " "                             
}

function default_header() {
  printf %"$COLUMNS"s | sed "s/ /$h_line/g"
echo
}

function main() {
setterm --cursor off
setterm --linewrap off

default_header
fetch "$border"\       " border >>"" $(get_border)"\                  "$border"
fetch "$border"\       " os >>"""""""""""" $(get_os) ($(get_arch))"\       "$border"
fetch "$border"\       " term >>"""""""""" $(get_term)"\               "$border"
fetch "$border"\       " date >>"""""""""" $(get_date)"\           "$border"
fetch "$border"\       " song >>"""""""""" $(get_song)"\               "$border"
fetch "$border"\       " kernel >>"""""""" $(get_kernel)"\             "$border"
fetch "$border"\       " shell >>"""""""" $(get_shell)"\               "$border"
fetch "$border"\       " battery >>"""""" $(get_battery)"\             "$border"
fetch "$border"\       " uptime >>"""""" $(get_uptime)"\               "$border"
fetch "$border"\       " packages >>"""" $(get_packages)"\             "$border"
default_header
setterm --cursor on
setterm --linewrap on
echo -ne '\n'
}



[ ! -d ~/.config/alfetch ] && mkdir -p ~/.config/alfetch

if [ -f ~/.config/alfetch/alfetch.config.conf ]; then #echo found

conf_value=$(awk -F"'" '/ALFETCH_CONF_VCODE/{print $2}' ~/.config/alfetch/alfetch.config.conf)

    if [ "$conf_value" == "$ALFETCH_CONF_VCODE" ]; then


      source ~/.config/alfetch/alfetch.config.conf 

   else
      echo "Wrong config!"; 
   fi
else
     main
fi
