#!/data/data/com.termux/files/usr/bin/bash # Cannot execute, source file
# ---BASH EXECUTECHECK--- #

# name:.alrc autoload for initial command at Terminal emulator, but this for Termux.
# version : alrc since v3.2.2 (19/06/2023) UTC+7
# license : GNU/GPLv3
# copyright (c) 2023 @adharudin14@gmail.com

# mode:rcfile like bashrc or shrc or something else
# sh-shell:bash (bourne again shell)

# .alrc script variant from al & whatisal functions but this specially for /sdcard apply on initial command
: ' based from al & whatisal functions '
: ' al & whatisal are minimal functions for /etc/fpath written by @adharudin14 '
# Do not call me when any sh there, source only!


 
#  set -xv


export ALRC_VERSION="4.3.3e"

ALRC_UDATE='26/04/24 00:54 WIB'

if [ "$ALRC_USE_ENV_PATH" == "true" ]; then
export ALRC_HOME="$(cd -P -- "$(dirname -- "$(readlink "${BASH_SOURCE[0]}")")" && "${ZTMEXLUIS_MOD}"/${module_name}-${module_version}/alrc-termux.sh)"
# kode diatas akan error jika ada file .env dimanapun atau plugin env diaktifkan solusi unset saja ALRC_USE_ENV_PATH dan gunakan ALRC_HOME dengan nilai default
export ALRC_SOURCE="alrc-termux.sh"
export ALRC_SCRIPT="$ALRC_HOME/$ALRC_SOURCE"

else
export ALRC_HOME="$HOME/.local/share/alrc-termux"
export ALRC_SOURCE="$(basename ${ALRC_HOME}.sh)"
export ALRC_SCRIPT="$ALRC_HOME/$ALRC_SOURCE"
fi

source $ALRC_HOME/lib/plugin_handler.sh
source $ALRC_HOME/lib/check_dependency.sh
source $ALRC_HOME/lib/aliasrc.sh
source $ALRC_HOME/lib/fpath.sh

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

# String
warning_alfetch_required()
{
echo -e "${warn}WARN:${reset} The ${underline}boxes_motd_custom${reset} plugin is not actually active, because you have not set the ${italic}\$ALRC_USE_ALFETCH ${reset}variable.${reset}";
}


function al_about_author() {
  echo -e "Created by : \@luisadha " >&2;
  echo -e "Contrib. : \@fmways " >&2;
  echo -e "Copyright \(c\) 2023" >&2;
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
[[ -z "$1" ]] && al help | jq . || al "$1"
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


# String

local thanks="Thank you for using alrc-termux!"

local my_terminal="$(echo $(dirname ${PREFIX:=$SYSROOT}))"
local uptimes="$(busybox uptime -s)" > /dev/null 2>&1;
local batt="$(termux-battery-status 2>&1 | grep -cq 'command not found' || termux-battery-status | head -n 3 | awk '{print $2}' | tail -n 1| sed 's/,/%/g' )"
local prefix="$PREFIX/bin" 2> /dev/null;
local sysroot="$SYSROOT/bin" 2> /dev/null;


local batteries="${batt:-$(echo "unknown")}" > /dev/null 2>&1;

local packages_termux="$(command ls ${prefix} 2>/dev/null | wc -l || command ls ${sysroot} 2>/dev/null | wc -l) (usr/bin) " &>/dev/null;
local shell="$(echo "$0" |awk '{gsub(/.*[/]|[.].*/, "", $0)} 1')              ";

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

if [ "$ALRC_USE_ALFETCH" == "true" ]; then
setterm --cursor off
setterm --linewrap off
echo -ne '\n'
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
echo -e "$thanks"
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
echo -e "Use \`al' or \$al for view system informations" >&2;
echo -e "Need help? use \`whatisal'\n" >&2;
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
\t $al\t  same as above \`al'
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
"") al      ;; 
"random")
set +o noclobber
source $ALRC_HOME/lib/ext_command_helper.sh;        al_include_boxes_motd_custom; 

 [[ "$ALRC_USE_ALFETCH" != "true" ]] && warning_alfetch_required && unset -f warning_alfetch_required && return 0

setterm --cursor off
setterm --linewrap off
echo -ne '\n'
al | boxes -d $(al_shuf_boxes_design);
setterm --cursor on
setterm --linewrap on
echo -ne '\n'
   ;;
*)
set +o noclobber
source $ALRC_HOME/lib/ext_command_helper.sh; al_include_boxes_motd_custom; 

 [[ "$ALRC_USE_ALFETCH" != "true" ]] && warning_alfetch_required && unset -f warning_alfetch_required && return 0

setterm --cursor off
setterm --linewrap off
echo -ne '\n'
al | boxes -d $ALRC_MOTD_USE_BOXES
setterm --cursor on
setterm --linewrap on
echo -ne '\n'
      ;;
 esac

##- Enviroment variable
 unset HOME USER
HOME="${HOME:=/data/data/com.termux/files/home}" # fix home
USER="${USER:-$(id -un)}"
HOSTNAME="$(getprop net.hostname)"
PS1='\[\e[0;36m\]\u@${HOSTNAME}:\w${text}$\[\e[m\]'
export HOME USER HOSTNAME PS1



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
setterm --cursor on
setterm --linewrap on
unset -f warning_alfetch_required
