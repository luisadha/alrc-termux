# Config by luisadha within alrc-termux

# tmux new-session -d "bash --noprofile && cd ~/Analog\ \&\ Digital\ Clock/ && npx http-server"

echo -e "${reset}∆"


: INITIAL 'ALIASES'
. ~/.aliases > /dev/null 2>&1; #myTermux Configuration

alias code-server='env NODE_OPTIONS="--require $HOME/android_as_server.js" code-server' # by fmway
##
: INITIAL 'ENVIRONMENT'
export LC_ALL=en_US.UTF-8
export PATH=$PATH:/system/bin:/usr/local/bin:$HOME/.local/bin
export BASH_ARGV0='bash' # Digunakan untuk memperbaiki bug saat login ke GNU/Linux melalui PRoot-Distro 
export HISTCONTROL=$HISTCONTROL${HISTCONTROL+:}ignoredups:erasedups
export HISTFILESIZE=1000000
export HISTSIZE=1000000
export HISTIGNORE='history*'


##
: INITIAL 'BIND'
#Just pure awesomeness!
bind '"\e[A"':history-search-backward
bind '"\e[B"':history-search-forward
bind Space:magic-space
##

: INITIAL 'OPTIONS'
shopt -s histappend
shopt -s checkwinsize
shopt -s cdspell
shopt -s cmdhist

: INITIAL 'VARIABLE'
PROMPT_DIRTRIM=3


: INITIAL 'POSIX OPTIONS'
# set +o errexit
  set +o noclobber
  set -o history


: INITIAL 'FUNCTION'
interrupt_handler()       {

# experimental anda boleh mematikan fungsi ini jika tidak tertarik

  local PID=$$
    echo "[Process not completed anyway (signal 9) - press Enter for confirm] "
  #  read -s -d $'\n' waitInput
read -s -n 1 -d $'\n' waitInput

if [[ -z "$waitInput" ]]; then
#    input keyevent 4
# input keyevent 4
 set -e
pgrep -f com.termux | grep -o $PID | kill $PID | exit

else
  echo "Input is not Enter. Abort!"
fi
    # Tambahkan tindakan khusus Anda di sini (opsional)
                          }

trap interrupt_handler SIGINT



function fancytext()       {
# by wibi9424
                            homeDirectory=$(eval echo ~)
                            php -r "include('${homeDirectory}/wibi9424/fancy_text/fancytext.php'); echo fancytext($1, '$2')[1];"
                            }


: INITIAL ' BODY '                            
if [ -n "$SSH_CLIENT" ]; then text=" ssh"; fi



# ================ alrc-termux Configuration ===================================================
# Alrc-Termux version 3.0.x method
#
#if [ -r /data/data/com.termux/files/home/.local/bin/alrc-termux.sh ]; then
#echo -e "\n**Alrc-Termux Activated**"
# . /data/data/com.termux/files/home/.local/bin/alrc-termux.sh > /dev/null 2>&1;

# Alrc-Termux version 4.0.x method

 source <(~/.local/bin/alrc env)> /dev/null 2>&1; 

 # Enable plugins
 #
 al_include_collect_applist # kita akan mengaktfikan plugin collect_applist
 al_include_brandomusicxz # kita akan mengaktifkan plugin brandomusicxz untuk zsh
 al_exclude_brandomusic # kita akan menonaktifkan plugin default brandomusic legacy yang deprecated (sudah usang)
 brandomusic_disable

 al_exclude_brandomusicx
 brandomusicx_disable


# Automasi dibawah alrc-termux
###! Music Randomize
# Memutar music secara acak silahkan pilih antara brandomusic/q/v atau brandomusicx 
# ! Jangan mengaktifkan keduanya.

: ' \
  eval "(brandomusicq > /dev/null 2>&1)" #'
# atau 
: ' \
  eval "(brandomusic ~/music-repositories/twice)" #'
# atau
# : ' \
  export BRANDO_RESPONSE=y
  export BRANDO_NO_CACHE=true
  al_include_brandomusicv # kita akan mengaktifkan plugin brandomusicv versi brandomusic yang disarankan dan stabil

  brandomusicv #&> /dev/null;
# jika perintah ini ditulis di .bashrc maka automisasi brandomusicv dimulai

# atau
: 'eval "(brandomusicx shuffle)" '
# atau 
#: BEGIN MUTLIPLE COMMENT'
export ANIMATION_STATE="terpilih" ANIMATION_MESSAGE="Memilih lagu"

#eval "(animation.sh "brandomusicx shuffle")"

#unset ANIMATION_STATE ANIMATION_MESSAGE

# dan
###! Image viewer Randomize
#
timgrandom;

export ANIMATION_STATE="terpilih" ANIMATION_MESSAGE="Memilih gambar"
eval "(animation.sh "imjpgrand ~")"

unset ANIMATION_STATE ANIMATION_MESSAGE

# ' ENDL


###! ================ end of alrc-termux Configuration ==============================

# Your Configuration can place this
#
# Example case you add Alternarif bash prompt

# source ~/.bash-powerline.sh
#
read isProot < <(uname -r | sed 's/^[^-]*-//'); [ $isProot == "PRoot-Distro" ] && echo "Hello $(cat /etc/*-release | sed -n 's/^NAME="\([^"]*\)"/\1/p')" && . ~/liquidprompt/liquidprompt 2>/dev/null;


cat <<- "EOF" > $HOME/android_as_server.js
// file android-as-linux.js
Object.defineProperty(process, "platform", {
  get() {
    return "linux"
  },
})
EOF


cat <<- "EOF" > $HOME/pouting_cat.sh
read -a pouting_cat < <((echo "$(echo -en 'smileys,\npaws,\nand nose,\nfurry friends;\noh joy!! ;3' | openssl dgst -binary | base64 | tr -d '\n' | base64 -d | command cat | tr -cd '[:print:]')"\ "$(echo "${pouting_cat[0]}" |tr -d '0-9' |cut -d '|' -f2 | cut -c 1-2 | sed 's/$/3/' | base64 | base64 -d)" )); export -a pouting_cat; alias pouting_cat='echo ${pouting_cat[1]}'

echo "${pouting_cat[1]} is $(printf "\U0001F63E\n")"
EOF

echo
source pouting_cat.sh # ini akan menampilkan angka 3 ketika login, namun jika di source akan muncul emoji text
echo '<-- -->'

source <(command cat ~/pouting_cat.sh) # paksa munculkan emoji text ketika login shell
source ~/storage/shared/termuxlauncher/.apps-launcher # termuxlauncher Configuration. Install apk first


# echo "Jika anda tidak melihat emoji anda login seperti biasa, jika ya anda memanggil dengan source"

# echo 'Now server run at http://127.0.0.1:8080' # aktifkan jika mini server aktif

# Untuk mengaktifkan fitur _alcat, biarkan kode dibawah ini menjadi yang terakhir dimuat (you commenting out al_enable_alcat at last line) pastikan untuk mengaktifkan set -o history anda jika tidak mengaktifkan alcat (you commenting al_enable_alcat) 

# >> Pilih salah satu dari ini
: 'al_include_alcat 2>/dev/null '
# atau
al #&& 
set -o history # Mandatory / Penting jika anda men source Alrc-Termux 


