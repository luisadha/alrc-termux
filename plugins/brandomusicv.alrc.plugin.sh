#! bash alrc-termux.module
#BrandomusicV offers a better version of BrandomusicQ at least it doesn't require a change to the export PATH="$PATH:/system/bin" for the input command keyevent but uses an environment variable. Read more (readme.md)

# Copyright (c) 2023 Luisadha, GNU GPLv3

set +o noclobber
function __brandomusicv()
{
  # Testing on Musik com.miui.player (6.4.20i)
  # Testing on Dialog Music Player phone.vishnu.dialogmusicplayer (v2.1.1)


  #export BRANDO_RESPONSE=
  export BRANDO_NO_CACHE=true
 
  # Variabel ini digunakan untuk aplikasi DMP, aktifkan variabel di .bashrc jika anda memutar dengan DMP player
  # Direkomendasikan untuk mengaktifkan variabel ini secara setinggan default untuk menghindari error

      _TMP=".tmp"
  if [[ $BRANDO_NO_CACHE == true ]]; then
      export _TMP=""
 source ~/.local/share/alrc-termux/plugins/brandomusicv.alrc.plugin.sh
  fi

local format='audio/mp3';
    local file="${1:+"${1}/*.mp3"}";
    local file2="${1-"${HOME}/downloads/*.mp3"}";
    local files=$(busybox ls ${file:-${file2}});
    local n="${#files[@]}";
    local pick="${files[RANDOM % n]}";
    local result="$(printf "${0:+${pick}}" | shuf -n 1)";
    local tmp="/sdcard/download/"$(basename "${result}")"$_TMP";
    cd "/sdcard/Download" &> /dev/null;
    cp -rf "${result}" "${tmp}" &> /dev/null;
    answer=$BRANDO_RESPONSE
    cat <<-EOF > $ALRC_HOME/cache/answer.txt
${answer}
EOF
    read -rd '' content < $ALRC_HOME/cache/answer.txt
    case "$answer" in 
        [Yy]*)
            eval `am start -a android.intent.action.VIEW -d file://"${tmp}" -t ${format} ` &> /dev/null;
            sleep 2;
            echo;
            
    
            if [ "$_TMP" == ".tmp" ]; then


           brandomusic-cache-clear.sh;
         else
           
            rm -f "${tmp}";
            fi
            cd - &> /dev/null
           return
        ;;
        *)
          
            rm -f "${tmp}";
            termux-toast "brandomusicv: error, 'BRANDO_RESPONSE' variable environment not set yet!";
            cd - &> /dev/null;
            return 0
        ;;
    esac
return
}
alias brandomusicv='setenv BRANDO_RESPONSE y && __brandomusicv'

plugin_shortname=$(echo "${BASH_SOURCE[0]}" | awk '{gsub(/.*[/]|[.].*/, "", $0)} 1' )
alrc_plugin_enabled+=($plugin_shortname)
readarray -t alrc_plugin_enabled <<< $(printf "%s\n" "${alrc_plugin_enabled[@]}" | sort -u)
unset plugin_shortname
