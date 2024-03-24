#! bash alrc-termux.module
# Alfetch - a CLI Bash script to show system information on Android devices in termux 
# Version : v0.0.5b
# Created : 9 November 2023
# Copyright (c) 2023 Luis Adha
#set -xv
version="v0.0.5d"
ALFETCH_CONF_VCODE='005'
# 0.0.5b
# ~ Fix bug minor
# ~ Replace tr to sed

unalias fetch &>/dev/null;
unalias battery &>/dev/null;

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
_s1_char='┌'
_p2_char='┘'
_s2_char='└'
_p1_char='┐'
_char='|'
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


# example usage
#printf %"$_min_cols"s && echo "$_char"
#printf %"$_min_cols"s && echo -e "$_char\rHELLO WORD"
#printf %"$_min_cols"s && echo -e "$_char\r${_char} HELLO WORD"
border() {
al_status_boxes_border;
}
: "
user() {
echo -n "$USER"
}
init() {

}
gpu() {

} "
cpu() {
  CPUINFO="$(cat /proc/cpuinfo | grep 'Hardware' | awk '{print $3,$6}')"
  echo -n "$CPUINFO"
}
: "
storage() {

} "
dpkgs() {
  echo -n "$(dpkg --get-selections | wc -l) (dpkg)"
}

ram() {
echo -n "$(free -m | awk '/Mem/{print $3"MiB / "$2}')MiB"
}
: "
model() {

} 
android_version() {

}
sdk() {

} 

baseband() {
}

abi() {
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

song() {
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
os() {
  echo -n "$(uname -so)"; }
term() {
  echo -n "$TERM"; }
arch() {
 uname -m || dpkg --print-architecture; }
get_date() {
  command date; 
}
battery() {
 local batt="$(termux-battery-status 2>&1 | grep -cq 'command not found' || termux-battery-status | head -n 3 | awk '{print $2}' | tail -n 1 | sed 's/,/%/g')";
    local batteries="${batt:-$(echo "unknown")}" > /dev/null 2>&1;
    echo -n "$batteries"; 
}
battery_state() {
if [ $(termux-battery-status | grep "status" | cut -d":" -f2 | tr "[:upper:]" "[:lower:]" | sed "s/\,//g" | sed "s/\"//g" | xargs | sed "s/^/D/g" | cut -c 1,3-12) == "Discharging" ]; then
echo "Discharging"
else
echo "Charging"
fi; }
uptimes() {
 uptime --pretty; }
packages() {
 local prefix="$PREFIX/bin" 2> /dev/null;
 local sysroot="$SYSROOT/bin" 2> /dev/null;
 local packages_termux="$(command ls ${prefix} 2> /dev/null | wc -l || command ls ${sysroot} 2> /dev/null | wc -l) (usr/bin) " &> /dev/null;
 echo -n "$packages_termux"; }
shell() {
if [ "$(basename "$SHELL")" = "bash" ]; then
  bash_version=$(bash --version | grep 'bash' | head -n1 | awk '{print $4}' | sed 's/\(.*\)(1)-release.*/\1/')
  echo -n "bash $bash_version";
elif [ "$(basename "$SHELL")" = "zsh" ]; then
  echo "zsh $ZSH_VERSION";
else
  echo "unknown";
fi; }

kernel() {
  uname -r; }



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
  printf '%*s%s' ${arg1:-0} " "                             
}

function default_header() {

  printf %"$COLUMNS"s | tr " " "-"
}

function main() {
#default_header
default_header
fetch ${_char}" "" ""▢ motd-border >>" "boxes ($(border))" "${_char}"
fetch ${_char}" "" "" os >>" "$(os) ($(arch))" "${_char}"
fetch ${_char}" "" "" term >>" "$(term)" "${_char}"
fetch ${_char}" "" "" date >>" "$(get_date)" "${_char}"
fetch ${_char}" "" "" song >>" "$(song)" "${_char}"
fetch ${_char}" "" "" kernel >>" "$(kernel)" "${_char}"
fetch ${_char}" "" "" shell >>" "$(shell)" "${_char}"
fetch ${_char}" "" "" battery >>" "$(battery)" "${_char}"
fetch ${_char}" "" "" uptime >>" "$(uptime)" "${_char}"
fetch ${_char}" "" "" packages >>" "$(packages)" "${_char}"
default_header
}



[ ! -d ~/.config/alfetch ] && mkdir -p ~/.config/alfetch #&& echo berhasi  lbuat





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
