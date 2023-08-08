#BrandomusicV offers a better version of BrandomusicQ at least it doesn't require a change to the export PATH="$PATH:/system/bin" for the input command keyevent but uses an environment variable. Read more (readme.md)BrandomusicV offers a better version of BrandomusicQ at least it doesn't require a change to the $export PATH="$PATH:/system/bin" for the input command keyevent but uses an environment variable. Read more (readme.md)BrandomusicV offers a better version of BrandomusicQ at least it doesn't require a change to the $export PATH="$PATH:/system/bin" for the input command keyevent but uses an environment variable. Read more (readme.md)

set +o noclobber
brandomusicv()
{
  #export BRANDO_RESPONSE=

local format='audio/mp3';
    local file="${1:+"${1}/*.mp3"}";
    local file2="${1-"${HOME}/downloads/*.mp3"}";
    local files=$(busybox ls ${file:-${file2}});
    local n="${#files[@]}";
    local pick="${files[RANDOM % n]}";
    local result="$(printf "${0:+${pick}}" | shuf -n 1)";
    local tmp="/sdcard/download/"$(basename "${result}")".tmp";
    cd "/sdcard/Download" &> /dev/null;
    cp -rf "${result}" "${tmp}" &> /dev/null;
    answer=$BRANDO_RESPONSE
    cat <<-EOF > ~/.local/bin/answer.txt
${answer}
EOF
    read -rd '' content < ~/.local/bin/answer.txt;
    case "$answer" in
        [Yy]*)
            eval `am start -a android.intent.action.VIEW -d file://"${tmp}" -t ${format} ` &> /dev/null;
            sleep 1;
            echo;
            brandomusic-cache-clear.sh;
            cd - &> /dev/null
        ;;
        *)
            rm -f "${tmp}";
            termux-toast "brandomusicv: error, 'BRANDO_RESPONSE' variable environment not set yet!";
            cd - &> /dev/null;
            return 0
        ;;
    esac
}
