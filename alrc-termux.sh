#!/data/data/com.termux/files/usr/bin/bash # Cannot execute, source file
# ---BASH EXECUTECHECK--- #

# name:.alrc autoload for initial command at Terminal emulator, but this for Termux.
# version : alrc v3.2.2 (19/06/2023) UTC+7
# license : GNU/GPLv3
# copyright (c) 2023 @adharudin14@gmail.com

# mode:rcfile like bashrc or shrc or something else
# sh-shell:bash (bourne again shell)

# .alrc script variant from al & whatisal functions but this specially for /sdcard apply on initial command
: ' based from al & whatisal functions '
: ' al & whatisal are minimal functions for /etc/fpath written by @adharudin14 '
# Do not call me when any sh there, source only!

 
 # set -xv


export ALRC_VERSION="4.3.2"

ALRC_UDATE='25/03/24 00:38:11 WIB'
# export ALRC_HOME="$(cd -P -- "$(dirname -- "$(readlink "${BASH_SOURCE[0]}")")" && pwd)"
export ALRC_HOME="$HOME/.local/share/alrc-termux"

export ALRC_SOURCE="$(basename ${ALRC_HOME}.sh)"

export ALRC_SCRIPT="$ALRC_HOME/$ALRC_SOURCE"

#for p in $ALRC_HOME/lib; do
#        [[ -d $p/. ]] || continue
#        [[ :$PATH: = *:$p:* ]] || #PATH=$p:$PATH
#done

#chmod +x $ALRC_HOME/lib/*

source $ALRC_HOME/lib/ext_command_helper.sh
source $ALRC_HOME/lib/plugin_handler.sh
source $ALRC_HOME/lib/check_dependency.sh

check_dependency xdg-open
check_dependency pandoc
check_dependency awk
check_dependency bc
check_dependency tput
check_dependency busybox
check_dependency wc
check_dependency mapfile
check_dependency getconf
check_dependency termux-battery-status
check_dependency gdb
check_dependency sed
check_dependency xargs
check_dependency cut

pushd $ALRC_HOME > /dev/null 2>&1;
pandoc README.md -o README.html
popd > /dev/null 2>&1;

bold=$(tput bold)
underline=$(tput smul)
italic=$(tput sitm)
info=$(tput setaf 2)
error=$(tput setaf 160)
warn=$(tput setaf 214)
reset=$(tput sgr0)

function al_about_author() {
  echo -e "Created by : @luisadha " >&2;
  echo -e "Contrib. : @fmways " >&2;
  echo -e "Copyright (c) 2023" >&2;
}
# echo "${info}INFO${reset}: This is an ${bold}info${reset} message"                ┆ 50 # echo "${error}ERROR${reset}: This is an ${underline}error${reset} message"
# echo "${warn}WARN${reset}: This is a ${italic}warning${reset} message"       
# ---BASH SHELLCHECK--- #
[ -z "$PS1" ] && return
# --------------------- #

# ----- ALRC BASE FUNCTION ------ #

# --------+ NEW!
function _alcat () {
# for source purpose test only
# cat file ini setelah prompt pertama muncul/1x penggunaan
# nama fungsi tidak akan ikut terhapus hanya pengunaanya saja yang 1x
# based bashrcat 
# alcat version 2 named _alcat


local _last_prog=$_
local _filename='alrc-termux.sh'
local _function_name=${FUNCNAME[0]}

if [ "$(basename ${_last_prog} 2>/dev/null )" != "$_filename" ]; then
command_not_found_handle ${_function_name} || \
# echo -e "\n${_function_name}: command not found" >&2;
 unset _alcat;
 set -o history 
  return 1
else
 cat "$_last_prog";
 set -o history 
fi
 return 0
}

function al_export_func () {
local opts="$1"
local mod_name=("imjpgrand" "ranpper-termux" "brandomusicx")
if [ -z "$opts" ]; then
echo ""
elif [ "$opts" == "imjpgrand" ]; then
  source alrc-termux.sh
local name="${mod_name[0]}"
local parse=$(echo "$(type -a $name | wc -l) - 3" | bc)
type -a $name | tail -n $parse | head -n "$(echo "$parse - 1" | bc)" > ${name}.sh
sleep 1;
  echo "${info}INFO${reset}: Creating... file for ${bold}${name}${reset} "
  sleep 1;
 echo "${info}INFO${reset}: Done!"
elif [ "$opts" == "brandomusic" ]; then
echo "${error}ERROR${reset}: This is a ${underline}specially${reset} function, can't export to file!";
elif [ "$opts" == "ranpper-termux" ]; then
  source alrc-termux.sh
local name1="${mod_name[1]}"
local parse1=$(echo "$(type -a $name1 | wc -l) - 3" | bc)
  type -a $name1 | tail -n $parse1 | head -n "$(echo "$parse1 - 1" | bc)" > ${name1}.sh
  sleep 1;
  echo "${info}INFO${reset}: Creating... file for ${bold}${name1}${reset} "
  sleep 1;
  echo "${info}INFO${reset}: Done!"
elif [ "$opts" == "brandomusicx" ]; then
  echo ""
else
  echo ""
fi




}
function al_notify()      { local args="$@";                                          read i < <(echo "$args");                                 eval "(al_set_window $i)";                                eval "$(termux-toast $i)";             echo "${i}"; }
function al_log () {
cat $ALRC_HOME/Changelog.al.txt
}
function alcat () {
  cat $ALRC_HOME/$ALRC_SOURCE
}
function al_runmanual () {
    
  cd $ALRC_HOME && xdg-open README.html
}
function al_opt () {
al help | jq .
}

function al_set_window() {

    title="$*"
    echo -ne "\033]0;$title \007"
}
function al_fetchSongInfo() {
isPlaying() {

 termux-media-player info | awk '{print $2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13,$14,$15}' | grep -v "Position:" | xargs
 }
isPlayingEdit() {
termux-media-player info | awk '{print $2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13,$14,$15}' | grep -v "Playing" | grep -v "Position:" | xargs
}

if [ $(isPlaying | awk '{print $1}') == "Playing" ]; then
 echo "$(isPlayingEdit) (Memutar)"
elif [ $(isPlaying | awk '{print $1}') == "Paused" ]; then
 echo "$(isPlaying)" |  awk '{gsub("Paused", ""); print $0 " (Dijeda)"}'
else
 echo "unknown $(isPlaying)" | cut -d" " -f1
 fi
}

function al() {
local my_terminal="$(echo $(dirname ${PREFIX:=$SYSROOT}))"
local uptimes="$(busybox uptime -s)" > /dev/null 2>&1;
local batt="$(termux-battery-status 2>&1 | grep -cq 'command not found' || termux-battery-status | head -n 3 | awk '{print $2}' | tail -n 1| sed 's/,/%/g' )"
local prefix="$PREFIX/bin" 2> /dev/null;
local sysroot="$SYSROOT/bin" 2> /dev/null;


local batteries="${batt:-$(echo "unknown")}" > /dev/null 2>&1;

# local packages="$(ls /system/bin/| wc -l) (bin) / $(ls /system/xbin/ | wc -l) (xbin)" > /dev/null 2>&1;
local packages_termux="$(command ls ${prefix} 2>/dev/null | wc -l || command ls ${sysroot} 2>/dev/null | wc -l) (usr/bin) " &>/dev/null;
local shell="$(echo "$0" |awk '{gsub(/.*[/]|[.].*/, "", $0)} 1')              ";
# Rentan
# 

#local batteries="$(termux-battery-status | head -n 3 | awk '{print $2}' | tail -n 1| sed 's/,/%/g')"

#local my_terminal="$(ps | grep 'term' | awk '{print $9}')"
#
#
#local packages_termux="$(ls /data/data/com.termux/files/usr/bin | wc -l) (termux usr/bin) " &>/dev/null;
#     
#
#local uptimes="$(busybox uptime -s)"
#
#local shell="$(echo "$0" |awk '{gsub(/.*[/]|[.].*/, "", $0)} 1')
#";
#'@

export opt="$1"
if [ -z "$opt" ]; then
  if [ $(basename $0) == "bash" ] || [ $(basename $0) == "bash.bin" ]; then
icon='|'
abc=$(echo "${icon} os >> $(uname -so)" | wc -L); cba=$(echo "$COLUMNS - $abc" | bc);
bcd=$(echo "${icon} arch >> $(uname -m)" | wc -L); dcb=$(echo "$COLUMNS - $bcd" | bc);
cde=$(echo "${icon} term >> ${TERM}" | wc -L); edc=$(echo "$COLUMNS - $cde" | bc);
def=$(echo "${icon} date >> $(date)" | wc -L); fed=$(echo "$COLUMNS - $def" | bc);
efg=$(echo "${icon} shell >> ${shell}" | wc -L); gfe=$(echo "$COLUMNS - $efg" | bc);
fgh=$(echo "${icon} kernel >> $(uname -r)" | wc -L); hgf=$(echo "$COLUMNS - $fgh" | bc);
ghi=$(echo "${icon} uptime >> ${uptimes}" | wc -L); ihg=$(echo "$COLUMNS - $ghi" | bc);
hij=$(echo "${icon} battery >> ${batteries}" | wc -L); jih=$(echo "$COLUMNS - $hij" | bc);
ijk=$(echo "${icon} packages >> ${packages_termux}" | wc -L); kji=$(echo "$COLUMNS - $ijk" | bc);
jkl=$(echo "${icon} bash source >> ${ALRC_SOURCE}" | wc -L); lkj=$(echo "$COLUMNS - $jkl" | bc);
mno=$(echo "${icon} songs >> $(al_fetchSongInfo)" | wc -L); onm=$(echo "$COLUMNS - $mno" | bc);

ENV="${ENV:-"/system/etc/mkshrc"}"
test $ENV;
if [ $? -eq 0 ]; then
  : "AKU DISINI"
#echo -e "
#Hello $(basename $SHELL)
#Welcome to: ${my_terminal:-"Termux "}"

if [ "$ALRC_USE_ALFETCH" == "true" ]; then
source "$ALRC_HOME/lib/alfetch.sh"

 

else
echo -e "$(printf %"$COLUMNS"s |tr " " "-")
| os >> $(uname -so)$(printf %"$cba"s "$icon" )
| arch >> $(uname -m)$(printf %"$dcb"s "$icon" )
| term >> ${TERM}$(printf %"$edc"s "$icon" )
| date >> $(date)$(printf %"$fed"s "$icon" )
| shell >> ${shell}$(printf %"$gfe"s "$icon" )
| songs >> $(al_fetchSongInfo)$(printf %"$onm"s "$icon" )
| kernel >> $(uname -r)$(printf %"$hgf"s "$icon" )
| uptime >> ${uptimes}$(printf %"$ihg"s "$icon" )
| battery >> ${batteries}$(printf %"$jih"s "$icon" )
| packages >> ${packages_termux}$(printf %"$kji"s "$icon" )
| bash source >> ${ALRC_SOURCE}$(printf %"$lkj"s "$icon" )
$(printf %"$COLUMNS"s |tr " " "-") ";
fi
#echo "alrc: al is a $(type -t al), More informations? you can type \`whatisal'"
else
echo "Your device isn't Android"
return 1
fi

else echo "Hello $(basename $0), please make sure your shell are bash"; return 1; fi

elif [ "$opt" == "os" ]; then
  uname -so;
  export  al_"$opt"="$(uname $_)"
 
elif [ "$opt" == "arch" ]; then
  export  al_"$opt"="$opt"
 dpkg --print-architecture;
 export  al_"$opt"="$(dpkg $_)"

elif [ "$opt" == "term" ]; then
  echo ${TERM};
  export  al_"$opt"="$(echo $_)"

elif [ "$opt" == "date" ]; then
  date;
  export  al_"$opt"="$(date)"

elif [ "$opt" == "shell" ]; then
 echo "${shell}";
 export  al_"$opt"="$(echo $_)"

elif [ "$opt" == "kernel" ]; then
  uname -r;
  export  al_"$opt"="$(uname $_)"

elif [ "$opt" == "uptime" ]; then
  echo ${uptimes};
  export  al_"$opt"="$(echo $_)"

elif [ "$opt" == "battery" ]; then
  echo "${batteries}";
  export  al_"$opt"="$(echo $_)"

elif [ "$opt" == "packages" ]; then
 echo "${packages_termux}";
 export  al_"$opt"="$(echo $_)"

elif [ "$opt" == "bash_source" ]; then
  echo "${ALRC_SOURCE}"
  export  al_"$opt"="$(echo $_)"
  ####
elif [ "$opt" == "ab" ]; then # bug#226_3761a
  getprop ro.build.ab_update;
  export  al_"$opt"="$(getprop $_)"
if [ "$(getprop ro.build.ab_update)" == "true" ]; then
 # export al_"$opt"="$(getprop $_)"
  echo "We detected that your device have an A/B system partition."
fi

elif [ "$opt" == "abi" ]; then
  getprop ro.product.cpu.abi;
  export  al_"$opt"="$(getprop $_)"

elif [ "$opt" == "treble" ]; then
  getprop ro.treble.enabled;
  export al_"$opt"="$(getprop $_)"
  if [ "$(getprop ro.treble.enabled)" == "true" ]; then
  echo "Your device includes support for Project Treble!"
  fi

elif [ "$opt" == "binder_arch" ]; then
  getconf LONG_BIT;
  export  al_"$opt"="$(getconf $_)"

elif [ "$opt" == "android" ]; then
  getprop ro.build.version.release;
  export  al_"$opt"="$(getprop $_)"

elif [ "$opt" == "sar" ]; then
  case "$(getprop ro.build.version.release)" in
  9) if [ $(getprop ro.build.system_root_image) == true ]; then
        echo "true";
          export  al_"$opt"="$(echo true)"

      fi;;
 1[0-12]) if [ $(getprop ro.build.system_root_image) == false ]; then
        echo "true"; 
        echo "Your device includes support for system-as-root!"
          export  al_"$opt"="$(echo true)"

      fi;;
   *)
		echo "false"
    export  al_"$opt"="$(echo unknown)"
    ;;
  esac

elif [ "$opt" == "cpu_arch" ]; then #bug 2722_234b {not consist result }
 # echo "this options require internet connection!"
  echo "$OPTARG"
  echo
  #curl -sS "https://en.m.wikipedia.org/wiki/ARM_architecture_family?action=raw" | grep -Eoi "name         = ARM 64/32-bit" | sed 's/ //g' | cut -c"6-" | sed 's/\/32-bit//g';
  export  al_"$opt"="$(curl $_)"

elif [ "$opt" == "vndk" ]; then
  getprop ro.vndk.version;
  export  al_"$opt"="$(getprop $_)"

else
echo -e "Available options: \n" >&2;

  alcat | grep -w '$opt' | awk '{print $5}' | sed 's/\];//g' | sed 's/\'\$opt'//g' | sed "s/''//g" | sort | grep -v -e '^[[:space:]]*$' | xargs -d "\n" | awk '{for(i=1;i<NF;i++)if(i!=NF){$i=$i","}  }1' | sed 's/^/[/' | sed 's/$/]/'  
fi


}

function whatisal() {

al_runmanual

echo -e "${ALRC_SOURCE} -whatisal v$ALRC_VERSION ($ALRC_UDATE) al and whatisal (functions) are minimal autoload for your termux alternate of neofetch to display system information just call it through source within your .bashrc.\n"
echo -e "Definitions: ";
echo -e "\"al is an exported alias for al\" (by default mkshrc MOD) or if any function named 'al' it must be called \"al is a function\". \n ";
echo -e "alias al come with mkshrc mod by @7175-xda-devoloper, but function named al come with this resource by @adharudin14 also this function. ";

echo -e "
usage#1: source **<(~/.local/bin/alrc env)** from within your **~.bash\_profile** or **~/.bashrc** file

usage#2: whatisal print this help message and return
\t al\t  review al and return
\t al help\t  print available options using json style
\t al_scan_opt\t  export all output from al options to enviroment var. use \`env\' or \`alvar\ al' to see effect al_scan_opt.
\t alvar\t  print variable name are exported
\t chsh -s bash\t  change shell to bash and exit \n
";
}
#function _exit()              # Function to run upon exit of shell.
#{
  #  echo -e "Goodbye $0"
   # set_window "Window $RANDOM"
   # $0
#}
#trap _exit EXIT
# ----- ALRC END FUNCTION ------ #

# ----- ALRC MISC ------- #
# -------------------------------- #
source $0 > /dev/null 2>&1 && until false; do sleep 1; done
al_set_window "successfully script called via source"; 

case "$ALRC_MOTD_USE_BOXES" in
"")
al;
  ;;
"random")
 boxes -s ${COLUMNS}x$(al | wc -l) -d $(al_shuf_boxes_design) <(al)
   
   ;;
*)
boxes -s ${COLUMNS}x$(al | wc -l) -d $ALRC_MOTD_USE_BOXES <(al)
   ;;
 esac


# --------------------------------- #

# ----- BASHRC ---------- #

### bashrc add  27 jan
 
##- Enviroment variable
 unset HOME USER
HOME="${HOME:=/data/data/com.termux/files/home}" # fix home
USER="${USER:-$(id -un)}"
HOSTNAME="$(getprop net.hostname)"
PS1='\[\e[0;36m\]\u@${HOSTNAME}:\w${text}$\[\e[m\]'
export HOME USER HOSTNAME PS1

##- Aliases

#  mksh aliases emulated
#alias autoload='builtin typeset -fu'
alias functions='builtin export -f'
alias integer='builtin typeset -i'
alias nameref='builtin typeset -n'
alias r='fc -e -'

#  personal aliases
#maintain_alias()  {

alias brandomusic-set_autoremove="sed 's/\#\ brandomusic-cache-clear\.sh/\ brandomusic-cache-clear\.sh/g' $ALRC_SCRIPT > $ALRC_SCRIPT.tmp; mv -f $ALRC_SCRIPT.tmp $ALRC_SCRIPT > /dev/null 2>&1; al_login;"
alias brandomusic+set_autoremove="sed 's/\ brandomusic-cache-clear\.sh/\#\ brandomusic-cache-clear\.sh/g' $ALRC_SCRIPT > $ALRC_SCRIPT.tmp; mv -f $ALRC_SCRIPT.tmp $ALRC_SCRIPT > /dev/null 2>&1; al_login;"
#                  }
#
# alias al
#
alias al_activate='source <(~/.local/bin/alrc env)'; 

alias alcatalias='alcat | grep -e "^alias"'; 
alias aligrep='alias | grep';

alias asciivideo="mpv --no-config  --vo=caca --really-quiet"
alias cd0='cd ~/storage/shared'
alias cdd='cd ~/storage/downloads'
alias cddc='cd ~/storage/dcim'
alias cddoc='cd ~/storage/shared/Documents'
alias cdm='cd ~/storage/music'
alias cdmo='cd ~/storage/movies'
alias cdsd='cd /sdcard'
alias cdpic='cd ~/storage/pictures'
alias chx='chmod +x'
alias cuprog='coreutils --coreutils-prog=${@}'
alias sdcardd='busybox ls /sdcard | grep "^D*"'
alias downtree='tree ~/storage/downloads'
alias egvarexpandemo='echo ${!BASH*}'
alias expcat='cp -f ${1} ${PREFIX}/bin/$1 &>/dev/null; chmod +xr ${PREFIX}/bin/${1} &>/dev/null; echo >&2 "error: missing arguments" '
alias fetch_colorbar='256colors2 | head -n 2 | tail -n 1'
alias fix_ctypes="exec "$BASH""
alias l='ls -lah'
alias la='exa --icons -lgha --group-directories-first'
alias ll='ls -lh'
alias lrsaw='busybox ls -rSaw ${COLUMNS}'
alias ls='exa --icons'
alias lw='ls' # if you typo will redirect to similiar commoane (ls)
alias lsa='ls -lah'
alias lt='exa --icons --tree'
alias lta='exa --icons --tree -lgha'
alias lol='echo 'your\ mom''
alias neodistro='neofetch --ascii_distro'
alias fix_lolcrab_gradient='fold -w$COLUMNS | lolcrab -ag'
alias check_jpgfiles='cd $OLDPWD; cd /sdcard; printf "%s %s %s %s\n" "$(find . ! -readable -prune -o -name "*.jpg" -type f -print | wc -l)" "totals .jpg" "files on /sdcard"; cd - &>/dev/null;'
alias check_emptyfolder='cd $OLDPWD; cd /sdcard; printf "%s %s %s %s\n" "$(find . ! -readable -prune -o -type d -empty -print | wc -l)" "totals empty " "folder on /sdcard"; cd - &>/dev/null;'
alias check_emptyfiles='cd $OLDPWD; cd /sdcard; printf "%s %s %s %s\n" "$(find . ! -readable -prune -o -type f -empty -print | wc -l)" "totals empty " "files on /sdcard"; cd - &>/dev/null;'
alias check_nomedia='cd $OLDPWD; cd /sdcard; printf "%s %s %s\n" "$(find . ! -readable -prune -o -name "*.nomedia" -type f -print | wc -l)" "totals .nomedia" "on /sdcard"; cd - &>/dev/null;'
alias open='termux-open'
alias openpdf='open --content-type pdf'
alias opendoc='open --content-type doc'
alias openppt='open --content-type ppt'
# alias openexcel='open --content-type'
alias openhtml='open --content-type html'
alias opentxt='open --content-type txt'
alias pacupd='pkg update'
alias pacupg='pkg upgrade'
alias pacupgupd='pkg update && pkg upgrade'
alias prefix='cd $PREFIX'
alias preview='fzf --preview='\''bat --color=always --style=numbers --theme OneHalfDark {}'\'' --preview-window=down'
alias proot-dinstalled='cd /data/data/com.termux/files/usr/var/lib/proot-distro/installed-rootfs; ls;'
alias proot-dlogin='proot-distro login '
# alias al_refresh_profile='source /data/data/com.termux/files/home/.bash_profile' #for refresh profile
alias vendor='getprop ro.product.manufacturer'
alias mfiles='am start -n 'me.zhanghai.android.files/.filelist.FileListActivity' --user 0 &> /dev/null'
# add periode 28-29 March
alias loghis='echo 'login' >> ~/.bash_history; login'
# convert loghis to login in body .bash_history


# Personal Listing directories by luisadha

## BACKUP ALIAS
#+Never use this alias for
alias llm='bat --theme OneHalfDark -p '

## OPTIONAL ALIASES
#+ mybe you like this

alias ls='exa --icons'


## MAiN ALIAS
#+Daily alias usage
#

alias lrsaw='command ls -rSaw $COLUMNS' # another option of ls by me
alias llrsaw='command ls -lrSaw $COLUMNS' # another option of ls by me part II.
alias lm='ls | llm' # the best one of ls from me
alias lgv='ls -la |grep -v'
alias llg='ls -la |grep'
# example usage
#+ lgv downloads && llg downloads | lolcat
# print listing directory $HOME and grep that queri 'downloads' with color
alias luisadha='bash $HOME/luisadha/luisadha-interactive-script.sh' # run collection script interactive by luisadha directly with one command

alias pickaxe='find . -type f | pick | xargs xdg-open'
alias peg='eval $(fc -ln 1 | pick)'
#alias drawercli="launch -l | grep -Exo '[a-z0-9:_-]+' | sort -u | xargs | lolcat -r"
# install an app termuxlauncher before using this alias



## FUNCTION
function check_ip_privates() {
  # by luisadha
    local ip=$(ip addr show | grep -Eo 'inet [0-9]+\.[0-9]+\.[0-9]+\.[0-9]+' | grep -Ev '127\.0\.0\.1' | grep -Eo '[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+')
    echo "$ip"
}
declare -f -x check_ip_privates;

function printalpha()     { for i in {a..z};                                          do type $i 2>/dev/null;                             done }
declare -f -x printalpha;
function cattypus()       {
# by luisadha
  if [ "$(type -t $1)" == "function" ]; then
echo "$(declare -f $1)";

elif [ "$(type -t $1)" == "alias" ]; then
  echo "$(alias $1)";
elif [ "$(type -t $1)" == "file" ]; then
  echo "$(cat $(type -p $1))";
else
  echo "$1 is'nt function, alias or file.";
  fi                       }
declare -f -x cattypus

function al_opt_scan {
# by luisadha

declare -a "$(al help 2>&1 | sed 's/,//g' | sed 's/\[//g' | sed 's/\]//g' | sed 's/^/VARIABEL=/g' | sed 's/\"//g' )"
al_notify "Exporting..."
for i in ${VARIABEL[@]}; do

  al $i &> /dev/null;
done
echo "Export success!, please type env and found "al_something= ..." "
}
declare -f -x al_opt_scan

function al_opt_extract {
  # Created by luisadha
  num=1;
  _max_al_opt=$(alvar -t al_);

    while [[ $num -le $_max_al_opt ]] ; do
      eval "alvar -xn $num al_";
      ((num++));
      done > $ALRC_HOME/cache/$$.cache
      cat $ALRC_HOME/cache/$$.cache;
      cat $ALRC_HOME/cache/$$.cache | termux-clipboard-set
      termux-toast "Success add to clip!"
    rm -f $ALRC_HOME/cache/$$.cache

   # echo "cuangki top hebat" 1> x.out 2> x.err | termux-clipboard-set < x.out && termux-clipboard-get
}
declare -x -f al_opt_extract;


function setenv {
# function mksh
	eval export "\"$1\""'="$2"'
}
declare -x -f setenv


function bh { bash -c 'help '"$@"; }
declare -f -x bh
function timgrandom()     { pushd ~ &>/dev/null;                                           timg "$(realpath "${ARG:=$(busybox ls ~/**/*.jpg | shuf -n1)}")";                                            popd &>/dev/null; }                                             
declare -f -x timgrandom; #by luisadha 
function imjpgrand {
# by luisadha
dir="${1:+"${1}/*.jpg"}"
wd="${1-"${PWD}/*.jpg"}"
files=$(busybox ls ${dir:-${wd}})
 n=${#files[@]}
rand="${files[RANDOM % n]}"
img="$(printf "${0:+${rand}}" | shuf -n 1)";

termux-open --content-type image "$img" &>/dev/null ||\ {
if [ "$img" == "" ];
then echo "No such jpg files in this dir.";
else echo "$img are choosed!";
fi ||\ }

}
declare -f -x imjpgrand
function brandomusicq {
# Created by @luisadha 
  set +o noclobber
  set +m
  echo 'y' > $ALRC_HOME/cache/answer.txt;
  
  test $(echo $PATH | grep -o '/system/bin' | head -n1);

if [ $? -eq 0 ]; then
  
  function mainn() {
  
    (brandomusic & input text y & brandomusic &>/dev/null )
brandomusic-cache-clear.sh &> /dev/null;
  }
mainn;

else 
  echo "Please set value '/system/bin' into your \$PATH."
  echo "Before proced this action!"
  return 1
fi

}
declare -f -x brandomusicq
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
termux-media-player play "$(realpath "$(busybox ls ~/**/*.mp3 | shuf -n1)" )" > $ALRC_HOME/cache/title-songs.txt;
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
function brandomusic {
# builtin alrc-termux 
# USAGE : brandomusic DIR...
# Version: v1.2.2 : (What's new)
#  - Add feature custom parameter
#  - Add feature work without parameter 
# Version: v1.3.2 : (What's new)
#  - Add alias (brandomusic)-set_autoremove
#  - Add alias (brandomusic)+set_autoremove
#  - Add command (brandomusic)-cache-clear(.sh)
#  - Add file answer.txt on .local/bin
#  - Fix Major bug on cmd `ls'
#  - Fix minor bug on variable 'local file'
#  - Add feature one interactive input
#  - Add feature Time out within timeout toast
# Version: v1.4.6
#  - Add function (brandomusic)x 
#  - Add function (brandomusic)q
#  - Rename termux-toast
# Version : v1.4.7
#  - 

# Pemutar musik dinamis menggunakan "$PREFIX/bin/am"
#
# ------ Memutar lagu secara acak dari parameter yang ditentukan pengguna, juga dapat bekerja tanpa parameter.(nilai semula ditetapkan sebagai $HOME/downloads.
# ------ 
# Usage: brandomusic.sh [DIR...]
#           playing random .mp3 files on directory parameter

# Persyaratan: Membutuhkan aplikasi android pemutar music yang berjalan dilatar (Seperti aplikasi bawaan)
#
# Diuji pada perangkat Redmi 10 C 

# License : GNU/GPLv3
# Copyright (c) 2023 @luisadha

set +o noclobber
local format='audio/mp3'
local format2='audio'

local file="${1:+"${1}/*.mp3"}" #jika argumen $1 is not NULL

local file2="${1-"${HOME}/downloads/*.mp3"}" #jika argumen $1 is NULL

local files=$(busybox ls ${file:-${file2}})

local n="${#files[@]}"       

local pick="${files[RANDOM % n]}"

local result="$(printf "${0:+${pick}}" | shuf -n 1)"

local tmp="/sdcard/download/"$(basename "${result}")".tmp" 

cd "/sdcard/Download" &>/dev/null;

cp -rf "${result}" "${tmp}" &>/dev/null;

    read -n 1 -t 5 -p "Please tick remember my choice, once you see the popup! Y?
" answer

cat <<- EOF > $ALRC_HOME/cache/answer.txt
${answer}
EOF

    case "$answer" in
        [Yy]* )
 #termux-open --content-type ${format2} ${tmp} &>/dev/null;
 eval `am start -a android.intent.action.VIEW -d file://"${tmp}" -t ${format} ` &>/dev/null; 
 sleep 1
echo
# brandomusic-cache-clear.sh
cd - &>/dev/null;;
        * ) rm -f "${tmp}" ; termux-toast "timeout or done!"; cd - &>/dev/null; return 0;;
    esac

}
declare -f -x brandomusic
function ranpper-termux {
#!/bin/bash
# ranpper.sh v1.0
# Since Thu May  9 19:00:28 WIB 2019

# ranpper-termux(.sh) aka (ranpper v2.1:FINAL)
# Wed Jan 18 12:45:27 WIB 2023
# GNU/GPLv3
# Copyright c 2023 @luisadha

local files=(${1?'no folder given!'}/*.jpg)
local n=${#files[@]}
local wallpaper="${files[RANDOM % n]}"
termux-wallpaper -f "$wallpaper" || echo "Something wen't wrong"; 
return 0
}
declare -f -x ranpper-termux 
# list_sort-by-size
function lsn {
(( $# > 0 )) && (ls -s "$@" | sort -n) \
|| (ls -s . | sort -n)
}
declare -f -x lsn
function lll { busybox ls -l "$@" | busybox awk '{ print $5,$9 }' | busybox sort -n
}
declare -f -x lll
function cu { coreutils --coreutils-prog=${@}; }
declare -f -x cu
function transfer {
# upload file to site transfer.sh
if [ $# -eq 0 ]; then echo "No arguments specified.\nUsage:\n transfer <file|directory>\n ... | transfer <file_name>" >&2;
return 1;
fi;

if tty -s; then file="$1";
file_name=$(basename "$file");
if [ ! -e "$file" ]; then echo "$file: No such file or directory" >&2;
return 1;
fi;
if [ -d "$file" ]; then
file_name="$file_name.zip" ,;(cd "$file"&&zip -r -q - .)|curl --progress-bar --upload-file "-" "https://transfer.sh/$file_name"| tee /dev/null,;
else cat "$file"| curl --progress-bar --upload-file "-" "https://transfer.sh/$file_name"|tee /dev/null;
fi

else
 file_name=$1;
curl --progress-bar --upload-file "-" "https://transfer.sh/$file_name" | tee /dev/null;
 fi;
}
declare -f -x transfer 
function convertime {
# converter secs to minutes, hours, days (readable format)

  local T=$1
  local D=$((T/60/60/24))
  local H=$((T/60/60%24))
  local M=$((T/60%60))
  local S=$((T%60))
  (( $D > 0 )) && printf '%d days ' $D
  (( $H > 0 )) && printf '%d hours ' $H
  (( $M > 0 )) && printf '%d minutes ' $M
  (( $D > 0 || $H > 0 || $M > 0 )) && printf 'and '
  printf '%d seconds\n' $S

}
declare -f -x convertime
function readwrites { 
# to remove readonly var

    declare -p $1 &>/dev/null || return -1 # Return if variable not exist
    local -n variable=$1
    local reslne result flags=${variable@a}
    [ -z "$flags" ] || [ "${flags//*r*}" ] && { 
        unset $1    # Don't run gdb if variable is not readonly.
        return $?
    }
    while read -r resline; do
        [ "$resline" ] && [ -z "${resline%%\$1 = *}" ] &&
            result=${resline##*1 = }
    done < <(
        exec gdb 2>&1 -ex 'call (int) unbind_variable("'$1'")' --pid=$$ --batch
    )
    return $result
}
declare -f -x readwrites 
# Check if command is in PATH
#function checkDep {     path=`command -v ${1}` && echo "${1} found at ${path}" || { echo "${1} not found" >&2 ; return 1; } } declare -f -x checkDep
function generateqr {
printf "$@" | curl -F-=\<- qrenco.de
}
declare -f -x generateqr
function duplicatefind {
find -not -empty -type f -printf "%s\n" | sort -rn | uniq -d | xargs -I{} -n1 find -type f -size {}c -print0 | xargs -0 md5sum | sort | uniq -w32 --all-repeated=separate
}
declare -f -x duplicatefind
function alvar()
{
#  before egvarexpan2
#  now renamed to alvar

  # Copyright (c) 2023 @luisadha
  # GNU/GPLv3 

function main()
(

  arg="$1";
  eval "echo" \$\{\!"$arg"\*\}

)

args="$1"

if [ -z "$args" ]; then

function usage()
(
echo '[' && type alvar | grep -w '$args' | awk '{print $5}' | sed 's/\];//g' | sed 's/\'\$args'//g' | sed "s/\"/\",/g" | cut -c"3-"  | sed "s/pe//" | sed s'/^/\"/' | sed '1,2 s/\"//g' | sed '/./,$!d' | sort && echo ']'
)

echo -e "" >&2; echo -e "alvar v1.0.4 - Parsing tools for variable enviroment, Copyright (c) 2023 @luisadha" >&2;
echo -e "Usage : alvar {QUERY VARIABLE ENVIRONMENT}" >&2;
echo -e "        alvar -xnf BASH // menampilkan informasi versi bash" >&2;
echo -e "" >&2;

# cut 1,3-34 # 50, 49
usage | xargs -d '\n' | cut -c"1,3-47",50 
echo '' >&2;
echo -e "Available options: \n" >&2;
#echo '' >&2;
echo -e "a,     Maksudnya tampilkan semua variable yang cocok berdasarkan queri." >&2;
echo -e "x,     Maksudnya ektrak nilai dari variabel queri" >&2;
echo -e "n NUM  Maksudnya menampilkan nama variable queri berdasarkan nomer spesifik." >&2;
echo -e "t,     Maksudnya menampilkan jumlah variable queri yang cocok dengan parameter yang ditentukan." >&2;
echo -e "nf,    Maksudnya tampilkan variable query yang terakhir, biasanya variable Seperti {QUERY}_VERSION dibeberapa kasus." >&2;
echo -e "{x, n}, Option ini dapat dikombinasikan dengan option tertentu." >&2;
echo "" >&2;


elif [ "$args" == "-nf" ]; then eval "echo" "$(main $2 | awk '{print $NF}')";
elif [ "$args" == "-xnf" ]; then eval "echo" "\$$(main $2 | awk '{print $NF}')";
elif [ "$args" == "-t" ]; then eval "echo" "$(main "$2" |  wc -w)";
elif [ "$args" == "-n" ]; then local alvar_notif=`echo "$2" | grep -E ^\-?[0-9]*\.?[0-9]+$`; 
   int="${alvar_notif:?'require number after '-n'.'}";
  eval "echo" "$(main $3 | cut -f$int -d ' ')";
elif [ "$args" == "-xn" ]; then local alvar_notif=`echo "$2" | grep -E ^\-?[0-9]*\.?[0-9]+$`;
   int2="${alvar_notif:?'require number after '-xn'.'}";
  eval "echo" "\$$(main $3 | cut -f$int2 -d ' ')";

elif [ "$args" == "-a" ]; then local num=1; local max=$(alvar -t $2 ); for i in `seq $num $max`; do  eval "alvar -n $i $2"; done;

elif [ "$args" == "-xa" ]; then local num=1; local max=$(alvar -t $2 ); for j in `seq $num $max`; do  eval "alvar -xn $j $2"; done;
else
 main $1 $2 $3;
fi
}
declare -f -x alvar

# fkill - kill processes - list only the ones you can kill. Modified the earlier script.
function fkill() {
    local pid 
    if [ "$UID" != "0" ]; then
        pid=$(ps -f -u $UID | sed 1d | fzf -m | awk '{print $2}')
    else
        pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')
    fi  

    if [ "x$pid" != "x" ]
    then
        echo $pid | xargs kill -${1:-9}
    fi  
}

declare -f -x fkill
function cd() {
  # interactive cd by @mgild 
    if [[ "$#" != 0 ]]; then
        builtin cd "$@";
        return
    fi
    while true; do
        local lsd=$(echo ".." && command ls -p | grep '/$' | sed 's;/$;;')
        local dir="$(printf '%s\n' "${lsd[@]}" |
            fzf --reverse --preview '
                __cd_nxt="$(echo {})";
                __cd_path="$(echo $(pwd)/${__cd_nxt} | sed "s;//;/;")";
                echo $__cd_path;
                echo;
                command ls -p --color=always "${__cd_path}";
        ')"
        [[ ${#dir} != 0 ]] || return 0
        builtin cd "$dir" &> /dev/null
    done
}
declare -f -x cd
function generate_abstraction()
{
file="$1"
timg "$file" | lolcrab -a
}
declare -f -x generate_abstraction
generate_addon_files() {
set +o noclobber
export PATH="${PATH}:$HOME/.local/bin"
ADDON_BRANDO="brandomusic-cache-clear.sh"
CHECKIP_FILES="check_ip_publics"

cat <<- "EOF" > $HOME/.local/bin/$ADDON_BRANDO

#!/usr/bin/env bash
# by luisadha
# generated by brandomusic
mapfile -d '' content < $ALRC_HOME/cache/answer.txt
content="${content[*]%$'\n'}"
read -rd '' content <  $ALRC_HOME/cache/answer.txt

if [ "$content" == "Y" ] || [ "$content" == "y" ]; then
echo "Deleting... "
 find /sdcard/Download -name '*.mp3.tmp*'  -print; 
 find /sdcard/Download -name '*.mp3.tmp*'  -exec rm {} +
  sleep 1
echo "Done!"
else
 echo -e "Run brandomusic first!"
 exit 1
fi

EOF

#
export IPFETCH="$ALRC_HOME/cache/ifconfig.txt"
echo '' > $IPFETCH
cat <<- "EOF" > $HOME/.local/bin/$CHECKIP_FILES

#!/usr/bin/env bash
# check_ip_publics v1.0.3
export ANIMATION_STATE=$(cat $IPFETCH)
eval "(animation.sh "curl -s -o ${IPFETCH} ifconfig.me")"
EOF

chmod +x $HOME/.local/bin/$ADDON_BRANDO
chmod +x $HOME/.local/bin/$CHECKIP_FILES
}

generate_addon_files;

 set +o history





