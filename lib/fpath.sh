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
echo "Maintenance in progress!"
return 0
: "
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
"
}
declare -f -x brandomusicq

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
echo "Maintenance in progress!"
return 0
: "
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
"
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

# Deprecreated replace with hide_soft_keyboard.py
# declare -f -x hide_soft_keyboard
